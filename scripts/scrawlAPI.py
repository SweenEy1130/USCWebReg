import json
import urllib

result = json.load(urllib.urlopen("http://petri.esd.usc.edu/socAPI/Schools/"))
for item in result:
	schoolCode = item["SOC_SCHOOL_CODE"]
	schoolName = item["SOC_SCHOOL_DESCRIPTION"]
	schoolResult = json.load(urllib.urlopen("http://petri.esd.usc.edu/socAPI/Schools/"+schoolCode))

	print "NSArray *"+schoolResult[0]["SOC_SCHOOL_DESCRIPTION"],
	deptNameList = []
	deptCodeList = []

	print "= @[",
	for dept in schoolResult[0]["SOC_DEPARTMENT_CODE"]:
		print "@\"%s\"," % (dept["SOC_DEPARTMENT_DESCRIPTION"]),
		deptNameList.append(dept["SOC_DEPARTMENT_DESCRIPTION"])
	print "];"
	# print "@[",
	# for dept in schoolResult[0]["SOC_DEPARTMENT_CODE"]:
	# 	print "@\"%s\"," % (dept["SOC_DEPARTMENT_CODE"]),
	# 	deptCodeList.append(dept["SOC_DEPARTMENT_CODE"])
	# print "]"
	#print deptNameList
	#print deptCodeList
