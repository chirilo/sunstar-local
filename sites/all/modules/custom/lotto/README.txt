README.txt
===========

pcsolotto is a module that downloads PCSO Lotto Results from www.pcso.gov.ph
and creates 2 drupal blocks, the PCSO Lotto featured results and PCSO Lotto results.

v1.3 - 2014-08-10
       Support both old and new PCSO website
       Old website source URL ends with "lotto-search.aspx"

v1.2 - Fixed error in displaying table header (2014-05-18)

Oldversions - Released sometime in 2009


Installation
==========
1. Extract pcsolotto.tgz into   public_html/sites/all/modules/
2. Enable pcsolotto module in  admin/build/modules
3. Create a PAGE to display the PCSO Lotto Results block
4. Configure "PCSO Lotto block" and show only on the PAGE you created in #3
5. Manual Update to display latest results
  open  admin/content/pcsolotto/settings
  Update Source Text field: 
  Click Save button
  Click Update button

6.  Configure header_logo_ads
http://www3.sunstar.com.ph/admin/build/block/configure/block/51
7. Change HTML of orig Lotto results page to :
<html>
<head>
<meta http-equiv="refresh" content="0;url=http://www.sunstar.com.ph/lotto-results">
</head>
<body>
This page has moved to <a href="http://www.sunstar.com.ph/lotto-results">http://www.sunstar.com.ph/lotto-results</a>
</body>
</html>
8. Configure block Weight 4   Region : Left Sidebar

http://www.sunstar.com.ph/node/18796/edit

AUTHOR/MAINTAINER
==================
dino simeon madarang <dmadarang@gmail.com>
