oc new-project couchbase \
&& oc new-build --name couchbase-server --binary \
&& oc start-build couchbase-server --from-file=centos-openshift-couchbase-container --follow \
&& oc new-app --name couchbase-server --image-stream=couchbase-server \
&& oc new-app --name couchbase-worker --image-stream=couchbase-server -e TYPE=WORKER -e COUCHBASE_MASTER=couchbase-server \
&& oc expose service couchbase-server \
&& make ocp-new-build-cb \
&& make ocp-start-build-cb \
&& make ocp-run-cb \
&& oc expose service cb-demo \
&& make ocp-new-build-beer \
&& make ocp-start-build-beer \
&& make ocp-run-beer \
&& oc expose service beer-demo