function [sComp] = sca_sig(for_data,ver_data, err_data,nShuffle,alpha)

%  PURPOSE:
%  This code estimates the signficance of SCA decomposition under the null hypothesis of no skill. 
%
%  NOTE: Code is written assuming the ver_data and err_data are not serially correlated. If data are serially correlated
%        then the data shuffling must account for the serial correlation. 
%
%  INPUTS:
%  for_data = matrix of forecast data (T x S), where S = space and T = time. Data are independent in time
%  ver_data = matrix of verification data (T x S), where S = space and T = time. Data are independent in time
%  err_data  = matrix of forecast error data (T x S), where S = space and T = time. Data are independent in time
%  nShuffle = number of repeated calculations of SCA under null hypothesis
%  alpha = signficance level*100 (i.e., 5%)
%
%  OUTPUT:
%  sComp.sig = the 100-2*alpha signficance curves for eigenvalue recovered from SCA under the null hypothesis of no skill.
%
%  REFERENCE:
%  Trenary, L., and DelSole, T. (2022): Advancing interpretability of machine learning prediction models. Environmental Data Science, 2022.
%  Code written by L. Trenary (1/2020).%

[ntime,nspace] = size(ver_data);
nt = 1:ntime;

   for nM = 1:nShuffle
         mInd1 = datasample(nt,ntime);
         mInd2 = datasample(nt,ntime);
         tErr = for_data(mInd1,:)-ver_data(mInd2,:);
         tVer = ver_data(mInd2,:);
          Stm = (tVer'*tVer)/ntime;
          Semt = (tErr'*tErr)/ntime;
         [eV,eL] = eig(Semt,Stm);
         eL = diag(eL);
         [sval,sind] = sort(eL,'ascend');
          eL = eL(sind);
          eV = eV(:,sind);
         sComp.eLdist(:,nM) = eL;
   end

%%% Estimate the signficance by finding the percentiles of the no-skill SCA %%%
sComp.sig = nan(nspace,2);
	for nmod = 1:nspace
       	 sComp.sig(nmod,1) = prctile(sComp.eLdist(nmod,:),alpha);
       	 sComp.sig(nmod,2) = prctile(sComp.eLdist(nmod,:),100-alpha);
	end
end
