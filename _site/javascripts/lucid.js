function addEvent(elm, evType, fn, useCapture) {
  // cross-browser event handling for IE5+, NS6 and Mozilla
  // By Scott Andrew
  if (elm.addEventListener) {
    elm.addEventListener(evType, fn, useCapture);
    return true;
  } else if (elm.attachEvent) {
    var r = elm.attachEvent('on' + evType, fn);
    return r;
  } else {
    elm['on' + evType] = fn;
  }
}

function iq_calendar_date() {
  // Display [month] [date] at end of author/date line
  // e.g. Posted by jamie about one day ago. Oct 31
  var spans = document.getElementsByTagName('span');
  for (var i=0; i<spans.length; i++) {
    if (spans[i].className.match(/\btypo_date\b/i)) {
      var months = new Array('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec');
      var date = new Date(spans[i].title);
      var month = months[date.getMonth()];
      var day = date.getDate();
      if (day < 10) day = '0' + day;
      spans[i].parentNode.innerHTML += '. <em>' + month + ' <span>' + day + '</span></em>';
    }
  }
}

var LIVE_SEARCH_PROMPT = "search here...";
// Array keys
var COLUMN_ORDER = 0;
var COLOR_SET = 1;
var LAYOUT = 2

// Defaults
var user_prefs = new Array('c-ms', 'cs0', 'fixed');

var results_displayed = false;
var sliding = false;
var search_focused = false;
var isSafari = ((parseInt(navigator.productSub)>=20020000) && (navigator.vendor.indexOf("Apple Computer")!=-1));

// Switch layout
function iq_switch_to_fixed() {
	iq_switch_pref(LAYOUT, 'fixed');
}
function iq_switch_to_fluid() {
	iq_switch_pref(LAYOUT, 'fluid');
}
// Switch color sets
function iq_switch_to_cs0() {
	iq_switch_pref(COLOR_SET, 'cs0');
}
function iq_switch_to_cs1() {
	iq_switch_pref(COLOR_SET, 'cs1');
}
function iq_switch_to_cs2() {
	iq_switch_pref(COLOR_SET, 'cs2');
}
// Switch a preference
function iq_switch_pref(pref, layout) {
	user_prefs[pref] = layout;
	if ($('theme-panel').style.display != 'none') Effect.BlindLeftIn('theme-panel');
	iq_set_body_class();
}
// Update body 'class'
function iq_set_body_class() {
	document.getElementsByTagName('body')[0].className = user_prefs.join(' ');
}
// Initialise layout stuff
function iq_add_layout_switcher() {
	// Set the defaults
	iq_set_body_class();

	// Register the onclicks
	addEvent(document.getElementById('layout-fixed'), 'click', iq_switch_to_fixed, false);
	addEvent(document.getElementById('layout-fluid'), 'click', iq_switch_to_fluid, false);
	addEvent(document.getElementById('layout-options'), 'click', iq_toggle_options, false);
	addEvent(document.getElementById('cs0_swatch'), 'click', iq_switch_to_cs0, false);
	addEvent(document.getElementById('cs1_swatch'), 'click', iq_switch_to_cs1, false);
	addEvent(document.getElementById('cs2_swatch'), 'click', iq_switch_to_cs2, false);
}

// Prefs

Effect.BlindLeftIn = function(element) {
  Element.makeClipping(element);
  new Effect.Scale(element, 0,
    Object.extend({ scaleContent: false,
      scaleY: false,
      afterFinish: function(effect)
        {
          Element.hide(effect.element);
          Element.undoClipping(effect.element);
        }
    }, arguments[1] || {})
  );
}

Effect.BlindLeftOut = function(element) {
  $(element).style.width   = '0px';
  Element.makeClipping(element);
  Element.show(element);
  new Effect.Scale(element, 100,
    Object.extend({ scaleContent: false,
      scaleY: false,
      scaleMode: 'contents',
      scaleFrom: 0,
      afterFinish: function(effect) {
        Element.undoClipping(effect.element);
      }
    }, arguments[1] || {})
  );
}

function iq_toggle_options() {
  if ($('theme-panel').style.display != 'none') {
    Effect.BlindLeftIn('theme-panel');
  } else {
    Effect.BlindLeftOut('theme-panel');
  }
}

// Adding the date conversions and search mods here is much
// nicer than embedding it in the layout in my opinion.
addEvent(window, 'load', show_dates_as_local_time, false);
addEvent(window, 'load', iq_calendar_date, false);
// addEvent(window, 'load', iq_add_layout_switcher, false);
