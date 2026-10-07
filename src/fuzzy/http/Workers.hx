package fuzzy.http;

import haxe.ds.Vector;

using Std;

// todo: make this fallback on non-threaded targets

@:allow(fuzzy.http.Workers)
class Worker {
  public var complete(default, null): Bool = true;

  var thread: sys.thread.Thread;

  public var name(get, null): String;

  inline function get_name() {
    return thread.name ?? "a worker";
  }

  function work() {
    while(true) {
      var next = sys.thread.Thread.readMessage(true);
      complete = false;
  
      if(next != null) {
        next();
  
        complete = true;
      }
    }
  }

  public function new(id: String) {
    this.thread = sys.thread.Thread.create(id, work);
  }
}

// abstract?
typedef Task = Void->Void;

class Workers {
  var workers: Vector<Worker>;

  var queue: Array<Task>;

  final id: String;
  public function new(size: Int = 8, id: String = 'workers') {
    this.id = id;

    this.workers = new Vector(size);
    for(i in 0...size) {
      final worker_id = '$id::worker($i)'; 
      final worker = new Worker(worker_id);

      trace('worker `${worker_id}` spawned');
      
      workers.set(i, worker);
    }

    this.queue = new Array();
  }

  public function work() {
    sys.thread.Thread.create('workers::work()', () -> while(true) {
      process();

      Sys.sleep(0.01);
    });
  }

  public function add(task: Task) {
    queue.push(task);
  }

  function process() {
    var next = queue.shift();

    if(next == null)
      return;

    for(worker in workers) {
      if(worker.complete) {
        trace("sent", next, "to", worker);
        worker.thread.sendMessage(next);
        
        break;
      }
    }
  }
}