###
*  Affililink v0.21
*  http://affililink.com
*  Created by Dean Barrow (http://deanbarrow.co.uk)
###

affililink = ->

  ### enter your affiliate codes below ###
  amazon_code = 'amazon.co.uk': '', 'amazon.com': '', 'amazon.de': '', 'amazon.fr': '', 'javari.co.uk': '', 'javari.de': '', 'javari.fr': '', 'amazonsupply.com': '', 'amazonwireless.com': '', 'endless.com': ''
  ebay_code = 'campaign': 0, 'country': ''
  options = 'replace_links': true, 'track_views': false, 'track_clicks': true

  ### DO NOT EDIT BELOW THIS LINE ###
  
  ### track analytics ###
  track = (url) ->
    if window.gat_ && window.gat_.getTracker_
      if options['track_clicks']
        url.setAttribute('onclick', "_gaq.push(['_trackEvent', 'Affililink', 'Click', "+url.href+"]);")
      if options['track_views']
        _gaq.push(['_trackEvent', 'Affililink', 'View', url.href])
    return true

  ### ebay ###
  ebay = (url) ->
    if ebay_code['campaign'] and ebay_code['country']
      ebay_domains = ['ebay.com.au', 'ebay.at', 'ebay.be', 'ebay.ca', 'ebay.ch', 'ebay.de', 'ebay.es', 'ebayanuncios.es', 'ebay.fr', 'ebay.ie', 'ebay.it', 'ebay.nl', 'ebay.co.uk', 'ebay.com', 'half.com']
      for ebay_domain in ebay_domains
        unless domain is ebay_domain or domain.substring(domain.length - ebay_domain.length - 1) is '.'+ebay_domain
          continue
          
        switch ebay_code['country']
          when 'AT'
            ebay_code['code'] = '5221-53469-19255-0'
          when 'AU'
            ebay_code['code'] = '705-53470-19255-0'
          when 'BE'
            ebay_code['code'] = '1553-53471-19255-0'
          when 'CA'
            ebay_code['code'] = '706-53473-19255-0'
          when 'CH'
            ebay_code['code'] = '5222-53480-19255-0'
          when 'DE'
            ebay_code['code'] = '707-53477-19255-0'
          when 'ES'
            ebay_code['code'] = '1185-53479-19255-0'
          when 'FR'
            ebay_code['code'] = '709-53476-19255-0'
          when 'IE'
            ebay_code['code'] = '5282-53468-19255-0'
          when 'IT'
            ebay_code['code'] = '724-53478-19255-0'
          when 'NL'
            ebay_code['code'] = '1346-53482-19255-0'
          when 'UK'
            ebay_code['code'] = '710-53481-19255-0'
          when 'US'
            ebay_code['code'] = '711-53200-19255-0'
        
        ### replace their link ###
        if domain is 'rover.ebay.com'
          if options['replace_links']
            url.href = url.href.replace /campid=([0-9]+)/g, 'campid=' + ebay_code['campaign']
            url.href = url.href.replace /rover\/1\/([0-9\-]+)/g, 'rover/1/' + ebay_code['code']
            return true
          else return false
          
        if domain.substring(domain.length - 'half.com'.length) is 'half.com'
          ebay_code['code'] = '8971-56017-19255-0'

        url.href = 'http://rover.ebay.com/rover/1/' + ebay_code['code'] + '/1?ff3=4&pub=5574962087&toolid=10001&campid=' + ebay_code['campaign'] + '&customid=affililink&mpre=' + encodeURIComponent(url.href)
        return true
        
  ### amazon & javari ###
  amazon = (url) ->
    amazon_domains = ['amazon.co.uk', 'amazon.com', 'amazon.de', 'amazon.fr', 'javari.co.uk', 'javari.de', 'javari.fr', 'amazonsupply.com', 'amazonwireless.com', 'endless.com']
    for amazon_domain in amazon_domains
      unless domain is amazon_domain or domain.substring(domain.length - amazon_domain.length - 1) is '.'+amazon_domain
        continue
      
      if not amazon_code[amazon_domain]
        return false
      
      # if existing affiliate tag
      if url.href.search(/tag=([a-z0-9\-]+)/) > -1
        if options['replace_links']
          url.href = url.href.replace /tag=([a-z0-9\-]+)/g, 'tag=' + amazon_code[amazon_domain]
          return true
        else return false
        
      # if trailing slash, remove it
      if url.href.substring(-1, 1) is '/'
        url.href = url.href.substring(0, url.href.length - 1)
        
      if not url.href.split("/")[3]
        url.href += '?tag=' + amazon_code[amazon_domain]
      else
        url.href += '&tag=' + amazon_code[amazon_domain]

      return true
        
  ### find all A tags ###
  a = document.getElementsByTagName('a')
  host = window.location.hostname

  ### loop through links ###
  for url in a
    ### remove internal links, mailto etc ###
    unless url.href.substring(0, 7) is 'http://' or url.href.substring(0, 8) is 'https://'
      continue
    domain = url.href.split("/")[2]
    if not domain
      continue
    else
      amazon url
      ebay url
      track url

### only run when page has loaded ###
if window.attachEvent
  window.attachEvent "onload", affililink
else
  if window.onload
    curronload = window.onload
    newonload = ->
      curronload()
      affililink()
    window.onload = newonload
  else
    window.onload = affililink
