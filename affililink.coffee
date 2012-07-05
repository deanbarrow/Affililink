###
*  Affililink v0.21
*  http://affililink.com
*  Created by Dean Barrow (http://deanbarrow.co.uk)
###

affililink = ->

  ### enter your affiliate codes below ###
  amazonCode = 'amazon.co.uk': '', 'amazon.com': '', 'amazon.de': '', 'amazon.fr': '', 'javari.co.uk': '', 'javari.de': '', 'javari.fr': '', 'amazonsupply.com': '', 'amazonwireless.com': '', 'endless.com': ''
  ebayCode = 'campaign': 0, 'country': ''
  options = 'replace_links': true, 'track_views': false, 'track_clicks': true

  ### DO NOT EDIT BELOW THIS LINE ###
  
  # track analytics
  track = (url) ->
    if window.gat_ && window.gat_.getTracker_
      if options['track_clicks']
        url.setAttribute('onclick', "_gaq.push(['_trackEvent', 'Affililink', 'Click', "+url.href+"]);")
      if options['track_views']
        _gaq.push(['_trackEvent', 'Affililink', 'View', url.href])
    return true

  # ebay
  ebay = (url) ->
    if ebayCode['campaign'] and ebayCode['country']
      ebayDomains = ['ebay.com.au', 'ebay.at', 'ebay.be', 'ebay.ca', 'ebay.ch', 'ebay.de', 'ebay.es', 'ebayanuncios.es', 'ebay.fr', 'ebay.ie', 'ebay.it', 'ebay.nl', 'ebay.co.uk', 'ebay.com', 'half.com']
      for ebayDomain in ebayDomains
        unless domain is ebayDomain or domain.substring(domain.length - ebayDomain.length - 1) is '.'+ebayDomain
          continue
          
        switch ebayCode['country']
          when 'AT'
            ebayCode['code'] = '5221-53469-19255-0'
          when 'AU'
            ebayCode['code'] = '705-53470-19255-0'
          when 'BE'
            ebayCode['code'] = '1553-53471-19255-0'
          when 'CA'
            ebayCode['code'] = '706-53473-19255-0'
          when 'CH'
            ebayCode['code'] = '5222-53480-19255-0'
          when 'DE'
            ebayCode['code'] = '707-53477-19255-0'
          when 'ES'
            ebayCode['code'] = '1185-53479-19255-0'
          when 'FR'
            ebayCode['code'] = '709-53476-19255-0'
          when 'IE'
            ebayCode['code'] = '5282-53468-19255-0'
          when 'IT'
            ebayCode['code'] = '724-53478-19255-0'
          when 'NL'
            ebayCode['code'] = '1346-53482-19255-0'
          when 'UK'
            ebayCode['code'] = '710-53481-19255-0'
          when 'US'
            ebayCode['code'] = '711-53200-19255-0'
        
        # replace their link
        if domain is 'rover.ebay.com'
          if options['replace_links']
            url.href = url.href.replace /campid=([0-9]+)/g, 'campid=' + ebayCode['campaign']
            url.href = url.href.replace /rover\/1\/([0-9\-]+)/g, 'rover/1/' + ebayCode['code']
            return true
          else return false
          
        if domain.substring(domain.length - 'half.com'.length) is 'half.com'
          ebayCode['code'] = '8971-56017-19255-0'

        url.href = 'http://rover.ebay.com/rover/1/' + ebayCode['code'] + '/1?ff3=4&pub=5574962087&toolid=10001&campid=' + ebayCode['campaign'] + '&customid=affililink&mpre=' + encodeURIComponent(url.href)
        return true
        
  # amazon, javari, endless, etc
  amazon = ->
    amazonDomains = ['amazon.co.uk', 'amazon.com', 'amazon.de', 'amazon.fr', 'javari.co.uk', 'javari.de', 'javari.fr', 'amazonsupply.com', 'amazonwireless.com', 'endless.com']
    for amazonDomain in amazonDomains
      unless domain is amazonDomain or domain.substring(domain.length - amazonDomain.length - 1) is '.'+amazonDomain
        continue
      
      unless amazonCode[amazonDomain]
        return false
      
      # if existing affiliate tag
      if url.href.search(/tag=([a-z0-9\-]+)/) > -1
        if options['replace_links']
          url.href = url.href.replace /tag=([a-z0-9\-]+)/g, 'tag=' + amazonCode[amazonDomain]
          return true
        else return false
        
      # if trailing slash, remove it
      if url.href.substring(-1, 1) is '/'
        url.href = url.href.substring(0, url.href.length - 1)
        
      unless url.href.split("/")[3]
        url.href += '?tag=' + amazonCode[amazonDomain]
      else
        url.href += '&tag=' + amazonCode[amazonDomain]

      return true
      
    addTagToEnd = (url) ->
    amazonDomains = ['amazon.co.uk', 'amazon.com', 'amazon.de', 'amazon.fr', 'javari.co.uk', 'javari.de', 'javari.fr', 'amazonsupply.com', 'amazonwireless.com', 'endless.com']
    for amazonDomain in amazonDomains
      unless domain is amazonDomain or domain.substring(domain.length - amazonDomain.length - 1) is '.'+amazonDomain
        continue
      
      unless amazonCode[amazonDomain]
        return false
      
      # if existing affiliate tag
      if url.href.search(/tag=([a-z0-9\-]+)/) > -1
        if options['replace_links']
          url.href = url.href.replace /tag=([a-z0-9\-]+)/g, 'tag=' + amazonCode[amazonDomain]
          return true
        else return false
        
      # if trailing slash, remove it
      if url.href.substring(-1, 1) is '/'
        url.href = url.href.substring(0, url.href.length - 1)
        
      unless url.href.split("/")[3]
        url.href += '?tag=' + amazonCode[amazonDomain]
      else
        url.href += '&tag=' + amazonCode[amazonDomain]

      return true
  
  a = document.getElementsByTagName('a')
  host = window.location.hostname

  for url in a
    # filter internal links, mailto etc
    unless url.href.substring(0, 7) is 'http://' or url.href.substring(0, 8) is 'https://'
      continue
    domain = url.href.split("/")[2]
    unless domain
      continue
    else
      amazon
      ebay
      track

# run once page has loaded
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
