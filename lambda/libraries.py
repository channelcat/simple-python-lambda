import os
import sys

# Import pip installed libraries

if 'LAMBDA_TASK_ROOT' in os.environ:
    sys.path.append(f"{os.environ['LAMBDA_TASK_ROOT']}/lib")
else:
    sys.path.append(os.path.join(os.path.dirname(os.path.realpath(__file__)), 'lib'))
