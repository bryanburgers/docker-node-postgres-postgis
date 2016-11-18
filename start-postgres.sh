#!/bin/bash
gosu postgres pg_ctl -D "$PG_DATA" -o "-c listen_addresses='localhost'" -w start
