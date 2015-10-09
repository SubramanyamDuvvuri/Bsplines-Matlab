function rmse = RMSE_calculate( data_known , data_prediction)
rmse= sqrt (sum((data_known - data_prediction).^2)/length(data_known));
end

