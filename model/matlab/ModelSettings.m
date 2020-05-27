classdef ModelSettings    
    properties
        % Model settings
        % ----------------------------------------------------------------------------------------
        gc  =  9.8153;        % Acceleration of gravity [m/s^2]
        g   = [0, 9.8153, 0]; % Array of 'g' for model  [{m/s^2, m/s^2, m/s^2}]
        Rad = 6378245;        % Earth radius            [m]
        h   = 200;            % Height above sea level  [m]
        M   = 5.9726e24;      % Earth mass              [kg]
        U   = 7.29e-5;        % Earth angular velocity  [rad/s]
        phi = 56 / 57.3;      % Moscow latitude         [rad]
        
        % Simulation settings
        % ----------------------------------------------------------------------------------------
        dt;                    % Alghoritm sampling period         [1/Hz]
        simulation_time;       % Alghoritm simulation time         [sec]
        simulation_iterations; % Alghoritm simulation itterations  [n]
        
        % Calibration settings
        % ----------------------------------------------------------------------------------------
        calibration_time = 2 * 60; % Alghoritm calibartion time        [sec] 
        calibration_iterations;    % Alghoritm calibration itterations [n]
        axels_calibration_results_file_name = 'axels_errors.txt';
        gyros_calibration_results_file_name = 'gyros_errors.txt';
        algorithm_results_errors_file_name  = 'errors.txt';

        % Sensors settings
        % ----------------------------------------------------------------------------------------
        axel_min_scale_factor = 1.2; 
        axel_max_scale_factor = 1.4;
        axel_bias             = 0.03924;      % Accelerometer bias [g]
        axel_sko              = 3.3e-4 * 9.8; % Accelerometer bias [g]
        
        gyro_min_scale_factor = 1.2; 
        gyro_max_scale_factor = 1.4;
        gyro_bias             = 0.03924;
        gyro_sko              = 0.03 / 57.3 / 3600;

        % Programm settings
        % ----------------------------------------------------------------------------------------
        font_size     = 25; % Font size of axis names on solutions plots
        font_size_sub = 15; % Font size of others names on solutions plots
        
        % Programm flags
        % ----------------------------------------------------------------------------------------
        debug_mode_flag              = true; % Print debug messeges in console, print debug graphics
        display_solutions_flag       = true; % Show solution graphics on screen
        subplot_print_flag           = true; % Print all solutions on one plot 
        log_algorithm_solutions_flag = true; % Store work resualt of alghorithm in file, save pictures
        
        % Calibration flags
        % ----------------------------------------------------------------------------------------
        calibration_mode_flag        = true; % Enable sensors calibration
        log_calibration_results_flag = true; % Store calibration resualt of alghorithm in file
        
        % Other variables
        % ----------------------------------------------------------------------------------------  
        solution_folder_name;                % Folder in which will be stored alghorithm solution errors file
        calibration_folder_name;             % Folder in which will be stored calibration files
        gyros_calibration_results_file_path; % Path to file which will be stored gyros calibration resualts
        axels_calibration_results_file_path; % Path to file which will be stored axels calibration resualts
        algorithm_results_errors_file_path;  % Path to file which will be stored algorithm results errors
    end
    
    methods
        function obj = ModelSettings(sim_time, sample_rate)
            disp('Creating settings object ...')
            obj.simulation_time = sim_time;
            obj.dt = 1 / sample_rate;
            
            obj.simulation_iterations = obj.simulation_time * sample_rate;
            obj.calibration_iterations = obj.calibration_time * sample_rate;
            
            obj.solution_folder_name = join(['./solutions/', datestr(datetime('now'), "yyyy-mm-dd_HH-MM-SS")]);
            obj.gyros_calibration_results_file_path = join([obj.solution_folder_name, '/', obj.gyros_calibration_results_file_name]);
            obj.axels_calibration_results_file_path = join([obj.solution_folder_name, '/', obj.axels_calibration_results_file_name]);
            obj.algorithm_results_errors_file_path = join([obj.solution_folder_name, '/', obj.algorithm_results_errors_file_name]);

            mkdir(obj.solution_folder_name);
            disp('Settings object creating successfully.')
        end
        
        % Programm flag setters
        % ------------------------------------------------------------------
        function obj = set_debug_mode_flag(obj, debug_mode)
            obj.debug_mode_flag = debug_mode;
            fprintf('Debug mode:            %d.\n', obj.debug_mode_flag);
        end
        
        function obj = set_display_solutions_flag(obj, display_solutions)
            obj.display_solutions_flag = display_solutions;
            fprintf('Display solution mode: %d.\n', obj.display_solutions_flag);
        end
        
        function obj = set_subplot_print_flag(obj, subplot_print)
            obj.subplot_print_flag = subplot_print;
            fprintf('Solution subplot mode: %d.\n', obj.subplot_print_flag);
        end
        
        function obj = set_log_algorithm_solutions_flag(obj, save_solutions)
            obj.save_solutions_flag = save_solutions;
            fprintf('Solution save:         %d.\n', obj.save_solutions_flag);
        end
    end
end