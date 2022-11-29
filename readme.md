 ## Installing
 `sudo docker compose up --build`

## Short version installation
```console
./configure
make
su
make install
adduser postgres
mkdir -p /home/pg/dist/postgresql-11.18/data
chown postgres /home/pg/dist/postgresql-11.18/data
su - postgres
/home/pg/dist/postgresql-11.18/bin/initdb -D /home/pg/data
/home/pg/dist/postgresql-11.18/bin/pg_ctl -D /home/pg//data -l logfile start
/home/pg/dist/postgresql-11.18/bin/createdb test
/home/pg/dist/postgresql-11.18/bin/psql test\
```

## Initializing database
```docker
RUN /home/pg/dist/postgresql-11.18/bin/initdb -D /home/pg/data 
  && /home/pg/dist/postgresql-11.18/bin/pg_ctl -D /home/pg/data start
RUN sudo -u postgres pg_ctl -D /home/pg/data start
```