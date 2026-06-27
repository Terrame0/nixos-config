{
  services.asusd = {
    enable = true;
    fanCurvesConfig.text = ''
      (
        performance: (
          name: Performance,
          min_percentage: 0,
          fan_curves: Some((
            enabled: [CPU, GPU],
            curves: {
              CPU: (
                fan: CPU,
                pwm: (102, 153, 204, 230, 255, 255, 255, 255),
                temp: (25, 40, 50, 60, 65, 70, 75, 80),
                enabled: true,
              ),
              GPU: (
                fan: GPU,
                pwm: (102, 153, 204, 230, 255, 255, 255, 255),
                temp: (25, 40, 50, 60, 65, 70, 75, 80),
                enabled: true,
              ),
            },
          )),
        )
      )
    '';
  };
}
