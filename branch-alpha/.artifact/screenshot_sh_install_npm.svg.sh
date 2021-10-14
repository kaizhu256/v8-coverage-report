(set -e
printf '> #!/bin/sh
> 
> npm install v8-coverage-report


'
#!/bin/sh

npm install v8-coverage-report 2>&1 | head -n 100
)
