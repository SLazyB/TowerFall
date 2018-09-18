import haxe.Timer;
using StringTools;

class Test {
  inline static var minuteInMs = 1000 * 60;
  inline static var hourInMs = minuteInMs * 60;
  inline static var dayInMs = hourInMs * 24;
      
  static function main() {
    var target = DateTools.delta(Date.now(), 5*minuteInMs);
    var targetTime = target.getTime();

    // run timer every second
    var timer = new Timer(1000);
    timer.run = function() {
      var now = Date.now().getTime();
      var remainingMs = targetTime - now;

      var days = Math.floor(remainingMs / dayInMs);
      var hours = Math.floor((remainingMs % dayInMs) / hourInMs);
      var minutes = Math.floor((remainingMs % hourInMs) / minuteInMs);
      var seconds = Math.floor((remainingMs % minuteInMs) / 1000);

      // Format ourselves for fun. We could have used `DateTools.format` here too
      var d = '$days'.lpad("0", 2);
      var h = '$hours'.lpad("0", 2);
      var m = '$minutes'.lpad("0", 2);
      var s = '$seconds'.lpad("0", 2);
      
      if (remainingMs > 0) {
        trace('$d days - $h:$m:$s');
      } else {
        trace('countdown expired!');
        timer.stop();
      }
    }
    return timer;
  }
}