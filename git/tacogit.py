import sys
try:
  print('v' + str(float(sys.argv[1][1:]) + 0.01))
except:
  print('v1.00')
