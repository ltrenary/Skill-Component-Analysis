function [sComp] = sca(ver_data, err_data)

%  PURPOSE:
%  This code finds SCA eigenvectors and corresponding time series. Note the SCA pattern for a particular skill component is found by regressing
%  the corresponding time series onto the forecast data. 
%
%  INPUT:
%  ver_data = matrix of verification data (T x S), where S = space and T = time
%  err_data  = matrix of forecast error data (T x S), where S = space and T = time
%
%  OUTPUT:
%  sComp.eof = the eigenvectors recovered from SCA
%  sComp.Rv = the SCA time series found by projecting verfication data onto the eigenvectors 
%  sComp.Re = the SCA time series found by projecting forecast error data onto the eigenvectors 
%
%  REFERENCE:
%  Trenary, L., and DelSole, T. (2022): Advancing interpretability of machine learning prediction models. Environmental Data Science, 2022.
%  Code written by L. Trenary (1/2020).

%%% Estimate the covariance matrices %%% 
    Se = (err_data'*err_data)/ntimem; %Covariance matrix for errors
    Sv = (ver_data'*ver_data)/ntimem; %Covariance matrix for verification data

    %%% Perform Eigen decomposition
    [eVec,eLambda] = eig(Se,Sv);
    eLambda = diag(eLambda); %Isolate the diagonal elements of the eigenvalue matrix to yield vector of values
    %%% Ensure eigenvectors are sorted in ascending order, such that the first component has the smallest eigenvalue (NMSE). 
    [sval,sind] = sort(eLambda,'ascend');
    eLambda = eLambda(sind);
    eVec = eVec(:,sind);

    sComp.eLam = eLambda;
    sComp.eVec = eVec;
    sComp.Rv =  ver_data*eVec;
    sComp.Re =  err_data*eVec;

end    
