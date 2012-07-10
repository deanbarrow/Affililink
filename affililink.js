/*
*  Affililink v0.21
*  http://affililink.com
*  Created by Dean Barrow (http://deanbarrow.co.uk)
*/
var affililink, curronload, newonload;
affililink = function() {
  /* enter your affiliate codes below */
  var a, addTagToEnd, amazon, amazonCode, domain, ebay, ebayCode, host, options, track, universalCode, url, _i, _len, _results;
  amazonCode = {
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
  ebayCode = {
    'campaign': 0,
    'country': ''
  };
  universalCode = {
    'appsumo.com': 'rf=1234'
  };
  options = {
    'replace_links': true,
    'track_views': false,
    'track_clicks': true
    /* DO NOT EDIT BELOW THIS LINE */
  };
  track = function() {
    if (window.gat_ && window.gat_.getTracker_) {
      if (options['track_clicks']) {
        url.setAttribute('onclick', "_gaq.push(['_trackEvent', 'Affililink', 'Click', " + url.href + "]);");
      }
      if (options['track_views']) {
        _gaq.push(['_trackEvent', 'Affililink', 'View', url.href]);
      }
    }
    return true;
  };
  ebay = function() {
    var ebayDomain, ebayDomains, _i, _len;
    if (ebayCode['campaign'] && ebayCode['country']) {
      ebayDomains = ['ebay.com.au', 'ebay.at', 'ebay.be', 'ebay.ca', 'ebay.ch', 'ebay.de', 'ebay.es', 'ebayanuncios.es', 'ebay.fr', 'ebay.ie', 'ebay.it', 'ebay.nl', 'ebay.co.uk', 'ebay.com', 'half.com'];
      for (_i = 0, _len = ebayDomains.length; _i < _len; _i++) {
        ebayDomain = ebayDomains[_i];
        if (!(domain === ebayDomain || domain.substring(domain.length - ebayDomain.length - 1) === '.' + ebayDomain)) {
          continue;
        }
        switch (ebayCode['country']) {
          case 'AT':
            ebayCode['code'] = '5221-53469-19255-0';
            break;
          case 'AU':
            ebayCode['code'] = '705-53470-19255-0';
            break;
          case 'BE':
            ebayCode['code'] = '1553-53471-19255-0';
            break;
          case 'CA':
            ebayCode['code'] = '706-53473-19255-0';
            break;
          case 'CH':
            ebayCode['code'] = '5222-53480-19255-0';
            break;
          case 'DE':
            ebayCode['code'] = '707-53477-19255-0';
            break;
          case 'ES':
            ebayCode['code'] = '1185-53479-19255-0';
            break;
          case 'FR':
            ebayCode['code'] = '709-53476-19255-0';
            break;
          case 'IE':
            ebayCode['code'] = '5282-53468-19255-0';
            break;
          case 'IT':
            ebayCode['code'] = '724-53478-19255-0';
            break;
          case 'NL':
            ebayCode['code'] = '1346-53482-19255-0';
            break;
          case 'UK':
            ebayCode['code'] = '710-53481-19255-0';
            break;
          case 'US':
            ebayCode['code'] = '711-53200-19255-0';
        }
        if (domain === 'rover.ebay.com') {
          if (options['replace_links']) {
            url.href = url.href.replace(/campid=([0-9]+)/g, 'campid=' + ebayCode['campaign']);
            url.href = url.href.replace(/rover\/1\/([0-9\-]+)/g, 'rover/1/' + ebayCode['code']);
            return true;
          } else {
            return false;
          }
        }
        if (domain.substring(domain.length - 'half.com'.length) === 'half.com') {
          ebayCode['code'] = '8971-56017-19255-0';
        }
        url.href = 'http://rover.ebay.com/rover/1/' + ebayCode['code'] + '/1?ff3=4&pub=5574962087&toolid=10001&campid=' + ebayCode['campaign'] + '&customid=affililink&mpre=' + encodeURIComponent(url.href);
        return true;
      }
    }
  };
  amazon = function() {
    var amazonDomain, amazonDomains, _i, _len;
    amazonDomains = ['amazon.co.uk', 'amazon.com', 'amazon.de', 'amazon.fr', 'javari.co.uk', 'javari.de', 'javari.fr', 'amazonsupply.com', 'amazonwireless.com', 'endless.com'];
    for (_i = 0, _len = amazonDomains.length; _i < _len; _i++) {
      amazonDomain = amazonDomains[_i];
      if (!(domain === amazonDomain || domain.substring(domain.length - amazonDomain.length - 1) === '.' + amazonDomain)) {
        continue;
      }
      if (!amazonCode[amazonDomain]) {
        return false;
      }
      if (url.href.search(/tag=([a-z0-9\-]+)/) > -1) {
        if (options['replace_links']) {
          url.href = url.href.replace(/tag=([a-z0-9\-]+)/g, 'tag=' + amazonCode[amazonDomain]);
          return true;
        } else {
          return false;
        }
      }
      if (url.href.substring(-1, 1) === '/') {
        url.href = url.href.substring(0, url.href.length - 1);
      }
      if (!url.href.split("/")[3]) {
        url.href += '?tag=' + amazonCode[amazonDomain];
      } else {
        url.href += '&tag=' + amazonCode[amazonDomain];
      }
      return true;
    }
  };
  addTagToEnd = function(links) {
    var link, match, match2, tag;
    for (link in links) {
      tag = links[link];
      if (!(domain === link || domain.substring(domain.length - link.length - 1) === '.' + link)) {
        continue;
      }
      if (!(link && tag)) {
        return false;
      }
      match = tag.match(/([a-zA-Z0-9\-]+)=([a-zA-Z0-9\-]+)/);
      if (!match[2]) {
        return false;
      }
      match2 = new RegExp(match[1] + '=([a-zA-Z0-9\-]+)');
      if (url.href.search(match2) > -1) {
        if (options['replace_links']) {
          url.href = url.href.replace(match2, match[1] + '=' + match[2]);
          return true;
        } else {
          return false;
        }
      }
      if (url.href.substring(url.href.length, url.href.length - 1) === '/') {
        url.href += '?' + match[1] + '=' + match[2];
        return true;
      }
      if (url.href.match(/(\?)/)) {
        url.href += '&' + match[1] + '=' + match[2];
      } else {
        url.href += '/?' + match[1] + '=' + match[2];
      }
      return true;
    }
  };
  a = document.getElementsByTagName('a');
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
      amazon();
      ebay();
      addTagToEnd(universalCode);
      track();
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
      curronload;      return affililink;
    };
    window.onload = newonload;
  } else {
    window.onload = affililink;
  }
}
