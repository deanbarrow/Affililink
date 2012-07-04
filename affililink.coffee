/*
*  Affililink v0.2
*  http://affililink.com
*  Created by Dean Barrow (http://deanbarrow.co.uk)
*/
var affililink, curronload, newonload;
affililink = function() {
  /* enter your affiliate codes below */
  var a, amazon, amazon_code, domain, ebay, ebay_code, host, track, tracking_code, url, _i, _len, _results;
  amazon_code = {
    'amazon.co.uk': '',
    'amazon.com': '',
    'amazon.de': '',
    'amazon.fr': '',
    'javari.co.uk': '',
    'javari.de': '',
    'javari.fr': '',
    'amazonsupply.com': '',
    'amazonwireless.com': '',
    'endless.com': ''
  };
  ebay_code = {
    'campaign': 0,
    'country': ''
    /* google analytics tracking */
  };
  tracking_code = {
    'ga': false
    /* DO NOT EDIT BELOW THIS LINE */
    /* track click analytics */
  };
  track = function(url, site) {
    if (tracking_code['ga']) {
      url.setAttribute('onclick', "_gaq.push(['_trackEvent', 'Affililink', " + site + ", " + url.href + "]);");
    }
    return true;
  };
  /* ebay */
  ebay = function(url) {
    var ebay_domain, ebay_domains, _i, _len;
    if (ebay_code['campaign'] && ebay_code['country']) {
      ebay_domains = ['ebay.com.au', 'ebay.at', 'ebay.be', 'ebay.ca', 'ebay.ch', 'ebay.de', 'ebay.es', 'ebayanuncios.es', 'ebay.fr', 'ebay.ie', 'ebay.it', 'ebay.nl', 'ebay.co.uk', 'ebay.com', 'half.com'];
      for (_i = 0, _len = ebay_domains.length; _i < _len; _i++) {
        ebay_domain = ebay_domains[_i];
        if (!(domain === ebay_domain || domain.substring(domain.length - ebay_domain.length - 1) === '.' + ebay_domain && domain !== 'rover.ebay.com')) {
          continue;
        }
        switch (ebay_code['country']) {
          case 'AT':
            ebay_code['code'] = '5221-53469-19255-0';
            break;
          case 'AU':
            ebay_code['code'] = '705-53470-19255-0';
            break;
          case 'BE':
            ebay_code['code'] = '1553-53471-19255-0';
            break;
          case 'CA':
            ebay_code['code'] = '706-53473-19255-0';
            break;
          case 'CH':
            ebay_code['code'] = '5222-53480-19255-0';
            break;
          case 'DE':
            ebay_code['code'] = '707-53477-19255-0';
            break;
          case 'ES':
            ebay_code['code'] = '1185-53479-19255-0';
            break;
          case 'FR':
            ebay_code['code'] = '709-53476-19255-0';
            break;
          case 'IE':
            ebay_code['code'] = '5282-53468-19255-0';
            break;
          case 'IT':
            ebay_code['code'] = '724-53478-19255-0';
            break;
          case 'NL':
            ebay_code['code'] = '1346-53482-19255-0';
            break;
          case 'UK':
            ebay_code['code'] = '710-53481-19255-0';
            break;
          case 'US':
            ebay_code['code'] = '711-53200-19255-0';
        }
        if (domain.substring(domain.length - 'half.com'.length) === 'half.com') {
          url.href = 'http://rover.ebay.com/rover/1/8971-56017-19255-0/1?ff3=8&pub=5574962087&toolid=10001&campid=' + ebay_code['campaign'] + '&customid=affililink&mpre=' + encodeURIComponent(url.href);
        } else {
          url.href = 'http://rover.ebay.com/rover/1/' + ebay_code['code'] + '/1?ff3=4&pub=5574962087&toolid=10001&campid=' + ebay_code['campaign'] + '&customid=affililink&mpre=' + encodeURIComponent(url.href);
        }
        track(url, 'eBay');
        return true;
      }
    }
  };
  /* amazon & javari */
  amazon = function(url) {
    var amazon_domain, amazon_domains, _i, _len;
    amazon_domains = ['amazon.co.uk', 'amazon.com', 'amazon.de', 'amazon.fr', 'javari.co.uk', 'javari.de', 'javari.fr', 'amazonsupply.com', 'amazonwireless.com', 'endless.com'];
    for (_i = 0, _len = amazon_domains.length; _i < _len; _i++) {
      amazon_domain = amazon_domains[_i];
      if (!(domain === amazon_domain || domain.substring(domain.length - amazon_domain.length - 1) === '.' + amazon_domain)) {
        continue;
      }
      if (amazon_code[amazon_domain]) {
        url.href = url.href.replace(/tag=([a-z0-9\-]+)/g, '');
        url.href = url.href.replace('&&', '&');
        if (url.href.substring(-1, 1) === '/') {
          url.href = url.href.substring(0, url.href.length - 1);
        }
        if (!url.href.split("/")[3]) {
          url.href += '?tag=' + amazon_code[amazon_domain];
        } else {
          url.href += '&tag=' + amazon_code[amazon_domain];
        }
        track(url, 'Amazon');
        return true;
      }
    }
  };
  /* find all A tags */
  a = document.getElementsByTagName('a');
  host = window.location.hostname;
  /* loop through links */
  _results = [];
  for (_i = 0, _len = a.length; _i < _len; _i++) {
    url = a[_i];
    /* remove internal links, mailto etc */
    if (!(url.href.substring(0, 7) === 'http://' || url.href.substring(0, 8) === 'https://')) {
      continue;
    }
    domain = url.href.split("/")[2];
    if (!domain) {
      continue;
    } else {
      amazon(url);
      ebay(url);
    }
  }
  return _results;
};
/* only run when page has loaded */
if (window.attachEvent) {
  window.attachEvent("onload", affililink);
} else {
  if (window.onload) {
    curronload = window.onload;
    newonload = function() {
      curronload();
      return affililink();
    };
    window.onload = newonload;
  } else {
    window.onload = affililink;
  }
}
