## An overview of Skill-Component-Analysis (SCA)
A method to identify skillfully predicted patterns based on finding combinations of variables that minimize the normalized mean square error $\textit{NMSE}$ of the predictions.  This technique is attractive because it compresses the positive skill of a forecast model into the smallest number of components.  The resulting components can then be analyzed much like principal components, including the construction of regression maps for investigating sources of skill. Moreover, the method is generalizable to any forecast system and can therefor be used in diagnosing the skill of a machine learning prediction model.

The details of the work are provided in Trenary and DelSole (2022), here we provide a brief overview. Let $t$ and $s$ denote the temporal and spatial indices, where $t = 1, \dots, T$ and $s = 1, \dots, S$.  Let $F(s,t)$ and $V(s,t)$ denote the anomaly forecast and target variables, respectively.  Then a linear combination over space is

$$r_V(t) = \sum_{s=1}^S q(s) V(s,t) \quad \text{and} \quad r_E(t) =  \sum_{s=1}^S q(s) \left ( F(s,t) - V(s,t) \right ),$$
where $q(s)$ contains the linear coefficients.  The $NMSE$ associated with this component can be written as

$$NMSE=\frac{\mathbf{q}^T \mathbf{\Sigma}_E \mathbf{q}} {\mathbf{q}^{T} \mathbf{\Sigma}_{V} \mathbf{q}}$$

where $\bf{\Sigma}_E$ and $\bf{\Sigma}_V$ are the sample covariance matrices of $( F(s,t) - V(s,t) )$ and $V(s,t)$, respectively. In SCA, we seek the $\mathbf{q}$ that minimizes the $NMSE$ in the expression above.   Following DelSole and Tippett (2022), this minimization problem leads to the generalized eigenvalue problem

$$\Sigma_{E}\mathbf{q} = \lambda  \Sigma_{V}\mathbf{q}.$$ 

Typically, this eigenvalue problem has $S$ distinct solutions, where the eigenvalue $\lambda$ gives the value of $NMSE$ corresponding to a given eigenvector $\mathbf{q}$.  Accordingly, the eigenvalues are ordered from \textit{smallest to largest}, $\lambda_1 < \dots < \lambda_S$, and the corresponding eigenvectors are denoted $\mathbf{q}_1, \dots, \mathbf{q}_S$.  The first eigenvector has the smallest possible $NMSE$ and is therefore the most skillful component.   The associated time series for this component is ${q}_1^T{V}$ obtained from the equation for $r_V$ given above.   The second eigenvector gives the smallest $NMSE$ out of all combinations whose time series are uncorrelated with the first, and is therefore the second most skillfully predicted pattern, and so on.  This methodology is analogous to Predictable Component Analysis, except Predictable Component Analysis, yields eigenvectors that maximize predictability, which is distinct from skill.  Note that unlike EOF analysis where the eigenvectors and principal component time series are separately orthogonal, in SCA only the time series are uncorrelated.


## In this repo ##
This repo to contains MATLAB subroutines for estimating the SCA given the forecast and errors and the corresponding statistical significance. The details of the inputs and outputs are provided in the code files. 

## References ##
Trenary, L., and DelSole, T. (2022): Advancing interpretability of machine learning prediction models. Environmental Data Science, 2022.

DelSole, T. and Tippett, M. (2022). Statistical Methods for Climate Scientists. 1st Edition,Cambridge University Press,
Cambridge. doi:10.1017/9781108659055.
