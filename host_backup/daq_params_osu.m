% This function generates:
%       calibration parameters 
%       motor parameters
%
% Based on CMU's "daq_params.m" sent to OSU on 8/8/2014, modified with 
% calibrations done on the OSU ATRIAS robot circa 8/14/2014
%
% Notes:
%   A/B use OSU naming convention
%   leg = shin/thigh encoders
%   trans = motor encoders

% Update rates
update_freq = 1000; %Hz
sample_time = 1/update_freq; % seconds

% Medulla state parameters
MEDULLA_STATE_IDLE  = 0;
MEDULLA_STATE_RUN   = 2;
MEDULLA_STATE_HALT  = 4;
MEDULLA_STATE_ERROR = 5;
MEDULLA_STATE_RESET = 6;

% Commands sent from the Instrument Panel/GUI to the system.
% These become parameters for the Simulink model
gui_enable_cmd  = 0; % Whether to enable the robot
gui_disable_cmd = 0; % Whether to disable the robot
gui_reset_cmd   = 0; % Whether to reset the robot (after a E-Stop)
gui_estop_cmd   = 0; % Whether to E-Stop the robot

% Low-level Medulla parameters
MEDULLA_ADC_OFFSET_COUNTS = 172;  % Ticks
MEDULLA_ADC_MAX_VOLTS     = 2.70; % Volts

% Renishaw Absolute 32-bit encoders
LEG_A_CALIB_LOC = pi + 0.305432619099008; % Radians
LEG_B_CALIB_LOC = pi - 0.305432619099008; % Radians

% Ticks to radians constants
BOOM_PITCH_ENCODER_RAD_PER_TICK = -2*pi / (2^17 * 2); % Ticks to rad constant = rad_per_rev / (ticks_per_rev * gear_ratio)
BOOM_ROLL_ENCODER_RAD_PER_TICK = 2*pi / (2^17 * 7); % Ticks to rad constant = rad_per_rev / (ticks_per_rev * gear_ratio)
BOOM_YAW_ENCODER_RAD_PER_TICK = 2*pi / (2^17 * 9.6); % Ticks to rad constant = rad_per_rev / (ticks_per_rev * gear_ratio)
HIP_INC_ENCODER_RAD_PER_TICK =  2*pi / (2500 * 4 * 57);  % Ticks to rad constant = rad_per_rev / (lines_per_rev * quadrature * gear_ratio)
HIP_ABS_ENCODER_RAD_PER_TICK = 2*pi / 2^13; % Ticks to rad constant = rad_per_rev / ticks_per_rev              

% Motor parameters
LEFT_MOTOR_HIP_DIRECTION = -1.0; %The direction for the left hip motor.
RIGHT_MOTOR_HIP_DIRECTION = 1.0; %The direction for the right hip motor.
MTR_MAX_COUNT = 19900; % The maximum commanded amplifier value. This is the maximum value sent to the Medullas for the amplifier command.
LEG_MOTOR_CONSTANT = 0.119;
HIP_MOTOR_CONSTANT = 0.184;
HIP_MTR_GEAR_RATIO = 57;
LEG_MTR_GEAR_RATIO = 50;

HIP_INC_MAX_ENCODER_TICKS = 2^16 - 1; % Max value of the incremental hip encoder (16-bit)
HIP_ABS_MAX_ENCODER_TICKS = 2^13 - 1; % Max value of the absolute hip encoder (13-bit)
BOOM_MAX_ENCODER_TICKS = 2^17 - 1; % Max value of the absolute boom encoders (17-bit)

% Calibrations done at OSU
RIGHT_HIP_CALIB_VAL = 1091;  %Calibration encoder value in ticks
LEFT_HIP_CALIB_VAL = 7192 - 2^13;   %Calibration encoder value in ticks
RIGHT_HIP_CALIB_POS = 0;  %Calibration angle in radians
LEFT_HIP_CALIB_POS = 0; %Calibration angle in radians
MTR_MAX_CURRENT = 155.0; %Maximum motor current for scaling
MTR_MAX_CONT_CURRENT = 100.0; %Maximum continuous amplifier current
MTR_HIP_MAX_CURRENT = 60.0; %Maximum hip motor current for scaling
BOOM_LENGTH = 2.006; % meters, center of rotation to hip center
BOOM_X_METERS_PER_TICK = -0.00000937522094511213193198; %The meters of boom motion per encoder tick. This is calculated from the boom's length, the number of encoder ticks per encoder revolution, and the gear ratio between the boom and the encoder.
LEG_MTR_MAX_TORQUE = MTR_MAX_CURRENT*LEG_MOTOR_CONSTANT*LEG_MTR_GEAR_RATIO;
LEG_MTR_MAX_CONT_TORQUE = MTR_MAX_CONT_CURRENT*LEG_MOTOR_CONSTANT*LEG_MTR_GEAR_RATIO;
LEG_MTR_MAX_VELOCITY = 393.755 / LEG_MTR_GEAR_RATIO; % Rad/s
HIP_MTR_MAX_TORQUE = MTR_HIP_MAX_CURRENT*HIP_MOTOR_CONSTANT*HIP_MTR_GEAR_RATIO;
CURRENT_LIMIT = 100;


LEG1_LEG_A_CALIB_VAL = 265635200; %Calibration encoder value in ticks
LEG1_TRAN_A_CALIB_VAL = 142852340; %Calibration encoder value in ticks
LEG1_LEG_B_CALIB_VAL = 174340930; %Calibration encoder value in ticks
LEG1_TRAN_B_CALIB_VAL = 142241870; %Calibration encoder value in ticks
LEG1_LEG_A_RAD_PER_CNT = -9.8039216e-09; %Ticks to rad constant
LEG1_TRAN_A_RAD_PER_CNT = 9.8039216e-09; %Ticks to rad constant
LEG1_LEG_B_RAD_PER_CNT = -9.8039216e-09; %Ticks to rad constant
LEG1_TRAN_B_RAD_PER_CNT = -9.8039216e-09; %Ticks to rad constant
LEG1_MOTOR_A_DIRECTION = -1.0; 
LEG1_MOTOR_B_DIRECTION = -1.0;

LEG2_LEG_A_CALIB_VAL = 265322590; %Calibration encoder value in ticks
LEG2_TRAN_A_CALIB_VAL = 142172760; %Calibration encoder value in ticks
LEG2_LEG_B_CALIB_VAL = 261290850; %Calibration encoder value in ticks
LEG2_TRAN_B_CALIB_VAL = 142444320; %Calibration encoder value in ticks
LEG2_LEG_A_RAD_PER_CNT = -9.8039216e-09; %Ticks to rad constant
LEG2_TRAN_A_RAD_PER_CNT = 9.8039216e-09; %Ticks to rad constant
LEG2_LEG_B_RAD_PER_CNT = 9.8039216e-09; %Ticks to rad constant
LEG2_TRAN_B_RAD_PER_CNT = -9.8039216e-09; %Ticks to rad constant
LEG2_MOTOR_A_DIRECTION = 1.0;
LEG2_MOTOR_B_DIRECTION = 1.0;

BOOM_PITCH_CAL_VALUE_RAD = 0;
BOOM_PITCH_CAL_VALUE_TICKS  = 43809; % ticks, pitch encoder reading when robot is vertical
BOOM_ROLL_CAL_VALUE_RAD = 0.1271; %Roll angle (in radians) for calibration point
BOOM_ROLL_CAL_VALUE_TICKS = 9318; %Roll encoder value for calibration point
BOOM_ROBOT_VERTICAL_OFFSET = 0.3434; % meters, 
BOOM_HEIGHT = 1.0287; % meters, top of the center of rotation to robot ground level

% Soft limits for motor positions
MOTOR_POSITION_LIMITS_UPPER = [4.9; 3.8; 2.5];
MOTOR_POSITION_LIMITS_LOWER = [2.5; 1.4; 0.4];

%% params for DAQ functions
fcut_smooth = 16*(2*pi); % Hz, low pass filter cutoff frequency for removing encoder dropouts
fcut_unwrap = 8*(2*pi); % Hz, low pass filter cutoff frequency for unwrapping angles
max_encoder_velocity = 200; % rad/s, max rate which encoder values can change
sensor_start_time = 8; % s
% two pole low-pass filter params for velocity estimation
fcut_velocity = 60*(2*pi); % Hz, low pass filter cutoff frequency for velocities
lpf_damping = sqrt(2)/2;
B1_lpf_velocity = -2*exp(-lpf_damping*fcut_velocity*sample_time)*cos(fcut_velocity*sample_time*sqrt(1-lpf_damping^2));
B2_lpf_velocity = exp(-2*lpf_damping*fcut_velocity*sample_time);
A_lpf_velocity = 1 + B1_lpf_velocity + B2_lpf_velocity;

% Parameters related to incremental encoder decoding
INC_ENC_RAD_PER_TICK = 2*pi/14000/LEG_MTR_GEAR_RATIO;
INC_ENC_DIRS         = -[ LEG1_MOTOR_A_DIRECTION
                          LEG1_MOTOR_B_DIRECTION
                          LEG2_MOTOR_A_DIRECTION
                          LEG2_MOTOR_B_DIRECTION ];
MEDULLA_TIMER_FREQ = 32e6;
