function app=SetTransmissibility(app,rate)
[app.alpha_2, app.beta_2 ,app.gamma_2, app.delta_2] = deal(rate*app.alpha_1, rate*app.beta_1 ,rate*app.gamma_1, rate*app.delta_1);
end