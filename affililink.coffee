# Affililink v0.2
# http://affililink.com
# Created by Dean Barrow (http://deanbarrow.co.uk)

# run affililink
affililink = ->

  # enter your affiliate info
  amazon = 'amazon.co.uk': '', 'amazon.com': '', 'amazon.de': '', 'amazon.fr': '', 'javari.co.uk': '', 'javari.de': '', 'javari.fr': ''
  ebay = 'campaign': 0, 'country': ''

  # find all A tags
  a = document.getElementsByTagName("a")
  host = window.location.hostname

  # loop through links
  for url in a
    # remove internal links, mailto etc
    unless url.href.substring(0, 7) is 'http://' or url.href.substring(0, 8) is 'https://'
      continue
    domain = url.href.split("/")[2]
    if not domain
      continue
    else
      
      # ebay
      if ebay['campaign'] and ebay['country']
        ebay_domains = ['ebay.com.au', 'ebay.at', 'ebay.be', 'ebay.ca', 'ebay.ch', 'ebay.de', 'ebay.es', 'ebayanuncios.es', 'ebay.fr', 'ebay.ie', 'ebay.it', 'ebay.nl', 'ebay.co.uk', 'ebay.com', 'half.com']
        for ebay_domain in ebay_domains
          unless domain is ebay_domain or domain.substring(domain.length - ebay_domain.length - 1) is '.'+ebay_domain and domain isnt 'rover.ebay.com'
            continue
            
          switch ebay['country']
            when 'AT'
              ebay['code'] = '5221-53469-19255-0'
            when 'AU'
              ebay['code'] = '705-53470-19255-0'
            when 'BE'
              ebay['code'] = '1553-53471-19255-0'
            when 'CA'
              ebay['code'] = '706-53473-19255-0'
            when 'CH'
              ebay['code'] = '5222-53480-19255-0'
            when 'DE'
              ebay['code'] = '707-53477-19255-0'
            when 'ES'
              ebay['code'] = '1185-53479-19255-0'
            when 'FR'
              ebay['code'] = '709-53476-19255-0'
            when 'IE'
              ebay['code'] = '5282-53468-19255-0'
            when 'IT'
              ebay['code'] = '724-53478-19255-0'
            when 'NL'
              ebay['code'] = '1346-53482-19255-0'
            when 'UK'
              ebay['code'] = '710-53481-19255-0'
            when 'US'
              ebay['code'] = '711-53200-19255-0'
            
          if domain.substring(domain.length - 'half.com'.length) is 'half.com'
            url.href = 'http://rover.ebay.com/rover/1/8971-56017-19255-0/1?ff3=8&pub=5574962087&toolid=10001&campid=' + ebay['campaign'] + '&customid=affililink&mpre=' + encodeURIComponent(url.href)
          else
            url.href = 'http://rover.ebay.com/rover/1/' + ebay['code'] + '/1?ff3=4&pub=5574962087&toolid=10001&campid=' + ebay['campaign'] + '&customid=affililink&mpre=' + encodeURIComponent(url.href)
 
      # amazon & javari
      amazon_domains = ['amazon.co.uk', 'amazon.com', 'amazon.de', 'amazon.fr', 'javari.co.uk', 'javari.de', 'javari.fr']
      for amazon_domain in amazon_domains
        unless domain is amazon_domain or domain.substring(domain.length - amazon_domain.length - 1) is '.'+amazon_domain
          continue
        
        if amazon[amazon_domain]
            url.href = url.href.replace /tag=([a-z0-9\-]+)/g,
            ''
          url.href = url.href.replace '&&', '&'
          if url.href.substring(-1, 1) is '/'
            url.href = url.href.substring(0, url.href.length - 1)
            
          if not url.href.split("/")[3]
            url.href += '?tag=' + amazon[amazon_domain]
          else
            url.href += '&tag=' + amazon[amazon_domain]

# only run when page has loaded
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
