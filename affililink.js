var affililink, curronload, newonload;
affililink = function() {
  var a, amazon, amazon_domain, amazon_domains, domain, ebay, ebay_domain, ebay_domains, host, url, _i, _j, _k, _len, _len2, _len3, _results;
  amazon = {
    'amazon.co.uk': 'affililink-21',
    'amazon.com': 'affililink-20',
    'amazon.de': '',
    'amazon.fr': ''
  };
  ebay = {
    'campaign': 5336854507,
    'country': 'UK'
  };
  a = document.getElementsByTagName("a");
  host = window.location.hostname;
  _results = [];
  for (_i = 0, _len = a.length; _i < _len; _i++) {
    url = a[_i];
    if (!(url.href.substring(0, 7) === 'http://' || url.href.substring(0, 8) === 'https://')) {
      continue;
    }
    domain = url.href.split("/")[2];
    if (!domain) {
      continue;
    } else {
      if (ebay['campaign'] && ebay['country']) {
        ebay_domains = ['ebay.com.au', 'ebay.at', 'ebay.be', 'ebay.ca', 'ebay.ch', 'ebay.de', 'ebay.es', 'ebayanuncios.es', 'ebay.fr', 'ebay.ie', 'ebay.it', 'ebay.nl', 'ebay.co.uk', 'ebay.com', 'half.com'];
        for (_j = 0, _len2 = ebay_domains.length; _j < _len2; _j++) {
          ebay_domain = ebay_domains[_j];
          if (!(domain === ebay_domain || domain.substring(domain.length - ebay_domain.length - 1) === '.' + ebay_domain && domain !== 'rover.ebay.com')) {
            continue;
          }
          switch (ebay['country']) {
            case 'AT':
              ebay['code'] = '5221-53469-19255-0';
              break;
            case 'AU':
              ebay['code'] = '705-53470-19255-0';
              break;
            case 'BE':
              ebay['code'] = '1553-53471-19255-0';
              break;
            case 'CA':
              ebay['code'] = '706-53473-19255-0';
              break;
            case 'CH':
              ebay['code'] = '5222-53480-19255-0';
              break;
            case 'DE':
              ebay['code'] = '707-53477-19255-0';
              break;
            case 'ES':
              ebay['code'] = '1185-53479-19255-0';
              break;
            case 'FR':
              ebay['code'] = '709-53476-19255-0';
              break;
            case 'IE':
              ebay['code'] = '5282-53468-19255-0';
              break;
            case 'IT':
              ebay['code'] = '724-53478-19255-0';
              break;
            case 'NL':
              ebay['code'] = '1346-53482-19255-0';
              break;
            case 'UK':
              ebay['code'] = '710-53481-19255-0';
              break;
            case 'US':
              ebay['code'] = '711-53200-19255-0';
          }
          if (domain.substring(domain.length - 'half.com'.length) === 'half.com') {
            url.href = 'http://rover.ebay.com/rover/1/8971-56017-19255-0/1?ff3=8&pub=5574962087&toolid=10001&campid=' + ebay['campaign'] + '&customid=affililink&mpre=' + encodeURIComponent(url.href);
          } else {
            url.href = 'http://rover.ebay.com/rover/1/' + ebay['code'] + '/1?ff3=4&pub=5574962087&toolid=10001&campid=' + ebay['campaign'] + '&customid=affililink&mpre=' + encodeURIComponent(url.href);
          }
        }
      }
      amazon_domains = ['amazon.co.uk', 'amazon.com', 'amazon.de', 'amazon.fr'];
      for (_k = 0, _len3 = amazon_domains.length; _k < _len3; _k++) {
        amazon_domain = amazon_domains[_k];
        if (!(domain === amazon_domain || domain.substring(domain.length - amazon_domain.length - 1) === '.' + amazon_domain)) {
          continue;
        }
        if (amazon[amazon_domain]) {
          url.href = url.href.replace(/tag=([a-z0-9\-]+)/g, '');
        }
        url.href = url.href.replace('&&', '&');
        if (url.href.substring(-1, 1) === '/') {
          url.href = url.href.substring(0, url.href.length - 1);
        }
        if (!url.href.split("/")[3]) {
          url.href += '?tag=' + amazon[amazon_domain];
        } else {
          url.href += '&tag=' + amazon[amazon_domain];
        }
      }
    }
  }
  return _results;
};
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
