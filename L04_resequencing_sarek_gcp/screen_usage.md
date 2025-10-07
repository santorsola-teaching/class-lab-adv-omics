## Check the running workflow
Launch a new screen session

```
screen
```
You’ll enter a new terminal environment where you can start your workflow, e.g.:

```
nextflow run hello
```

Find the session ID list of the current running screen sessions with:

```
screen -ls
```

You can re-attach the terminal session with:
```
screen -r <SCREEN_SESSION_ID>
```


To detach (leave it running in the background), press:
“Ctrl-A” and “d“

