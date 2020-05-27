classdef Accelerometer
    properties
        bias         = 0.03924; % [g]
        scale_factor = 1.3;
        
        % 'calculated_' values - values, obtained after the calibration procedure.
        % By default, this values are:
        calculated_bias         = 0; % [g]
        calculated_scale_factor = 1;
        
        sko;
    end
    
    methods
        function obj = Accelerometer(min_scale_factor, max_scale_factor, bias, sko)
            % Setting random (in [min_* : max_*] range) sensor errors
            obj.scale_factor = (min_scale_factor + rand * (max_scale_factor - min_scale_factor));
            obj.bias = (2 * randi([0 1]) - 1) * (-bias + rand * 2 * bias);
            
            obj.sko = sko;
            disp('Axelerometr created successfully.')
        end
        
        % Setting calibrated bias and scale facrot values
        function obj = set_calibrated_params(obj, calculated_bias, calculated_scale_factor)
            obj.calculated_bias = calculated_bias;
            obj.calculated_scale_factor = calculated_scale_factor;
            disp('Calibrated parameters seted successfully.')
        end
        
        function val = make_noise(obj, value)
            val = normrnd(value, obj.sko) * obj.scale_factor / obj.calculated_scale_factor + obj.calculated_bias - obj.bias;
        end
        
        function measured_value = measure(obj, value)
            measured_value = obj.make_noise(value);
        end
    end
end
