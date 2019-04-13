import urllib
import urllib2
import json
import sys

with open(sys.path[0]+'/session.json', 'r') as file:  
    session = json.load(file)

login_url = 'https://setup.icloud.com/setup/ws/1/storageUsageInfo'

opener = urllib2.build_opener()

opener.addheaders = [('Origin', 'https://www.icloud.com')]
opener.addheaders.append(('Cookie', "; ".join('%s=%s' % (k,v) for k,v in session['cookies'].items())))

endcode = urllib.urlencode(session['params'])
url = login_url + '?' + endcode
response = opener.open(url)

print(response.read().decode("utf-8"))