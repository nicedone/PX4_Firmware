
# rates used by the controller
float32 rollspeed		# Bias corrected angular velocity about X body axis in rad/s
float32 pitchspeed		# Bias corrected angular velocity about Y body axis in rad/s
float32 yawspeed		# Bias corrected angular velocity about Z body axis in rad/s

# rate controller integrator status
float32 roll_integ		# roll rate integrator
float32 pitch_integ		# pitch rate integrator
float32 yaw_integ		# yaw rate integrator
float32 additional_integ1	# FW: wheel rate integrator (optional)
