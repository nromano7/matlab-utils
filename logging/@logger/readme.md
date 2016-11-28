# logger

A simple message logger.

## Example

For a more lengthy demo, refer to `logger.example`.

For the short version:

    N = 10;
    logg = logger('Logged Loop Example');
    for n=1:N
      logg.task('Loop iteration',n,N)
      % do work
      logg.done()
    end
    logg.finish;


Output:

    LOG:	27-Nov-2016 23:18:45	Process(Logged Loop Example)	Starting "Logged Loop Example".
    LOG:	27-Nov-2016 23:18:45	Process(Logged Loop Example)	Logging to console.
    LOG:	27-Nov-2016 23:18:45	Process(Logged Loop Example)	Task(Loop iteration)	1	of	10	...	Done.
    LOG:	27-Nov-2016 23:18:45	Process(Logged Loop Example)	Task(Loop iteration)	2	of	10	...	Done.
    LOG:	27-Nov-2016 23:18:45	Process(Logged Loop Example)	Task(Loop iteration)	3	of	10	...	Done.
    LOG:	27-Nov-2016 23:18:45	Process(Logged Loop Example)	Task(Loop iteration)	4	of	10	...	Done.
    LOG:	27-Nov-2016 23:18:45	Process(Logged Loop Example)	Task(Loop iteration)	5	of	10	...	Done.
    LOG:	27-Nov-2016 23:18:45	Process(Logged Loop Example)	Task(Loop iteration)	6	of	10	...	Done.
    LOG:	27-Nov-2016 23:18:45	Process(Logged Loop Example)	Task(Loop iteration)	7	of	10	...	Done.
    LOG:	27-Nov-2016 23:18:45	Process(Logged Loop Example)	Task(Loop iteration)	8	of	10	...	Done.
    LOG:	27-Nov-2016 23:18:45	Process(Logged Loop Example)	Task(Loop iteration)	9	of	10	...	Done.
    LOG:	27-Nov-2016 23:18:45	Process(Logged Loop Example)	Task(Loop iteration)	10	of	10	...	Done.
    LOG:	27-Nov-2016 23:18:45	Process(Logged Loop Example)	Main process finished.
    LOG:	27-Nov-2016 23:18:45	Process(Logged Loop Example)	Alive for 0.75 seconds (0.01 minutes).
    LOG:	27-Nov-2016 23:18:45	Process(Logged Loop Example)	Shutting down...
    LOG:	27-Nov-2016 23:18:45	Process(Logged Loop Example)	Done.
