X=BS_value;
S = X*inv(X'*X + eye(length(X)))* X'
P_hat = (X'*X) ^-1 * X';

h_hat =X *(X'*X) ^-1 * X' ;
%y_hat = h_hat *ySensors;

    

