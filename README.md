# small-app
This application serves as a general purpose, single-repository microservices driven architecture.

The `frontend` and `backend` directories represent a service, which at scale, ideally have an actual physical separation (e.g., in individual repositories). This design is by no means perfect, but it possesses fundamentals for scalability and portability.

# Backend:
* The backend uses "primary" and "replication" for directory names, but ideally the containers they build do not. Backend directory contains the infrastructure for a primary postgres server and a replication/standby server, but the containers should, more or less, but instances agnostic in a sense.

If the database is supposed to be highly available at some point, the "primary" database could/would/should fail, and the "replication" would be promoted to the primary database. In this scenario, naming containers according to the infracture they were originally built from would lead to the primary database possessing the name "replication", which seems like a horrible idea.

A primary and replication server can be constructed according to these repositories, by the containers should be flexible to adapt to a changing landscape.