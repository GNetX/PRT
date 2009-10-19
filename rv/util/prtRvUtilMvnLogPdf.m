function Y = mvnLogPdf(X,mu,Sigma)
% MVNLOGPDF Multi-variate Normal Log PDF
%
% Syntax: Y = mvnLogPdf(X,mu,Sigma)
%
% Inputs:
%   X - Locations at which to evaluate the log pdf
%   mu - The mean of the MVN distribution
%   Sigma - The covariance matrix of the MVN distribution
%
% Outputs:
%   Y - The value of the log of the pdf at the specified X values

% Make sure Sigma is a valid covariance matrix
[R,err] = cholcov(Sigma,0);
if err ~= 0
    error('mvnlogpdf:BadCovariance', ...
        'SIGMA must be symmetric and positive definite.');
end

% Create array of standardized data, and compute log(sqrt(det(Sigma)))
xRinv = bsxfun(@minus,X,mu(:)') / R;
logSqrtDetSigma = sum(log(diag(R)));

Y = -0.5*sum(xRinv.^2, 2) - logSqrtDetSigma - length(mu)*log(2*pi)/2;
  