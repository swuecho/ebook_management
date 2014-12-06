drop table if exists upload;
create table upload (
        id          integer     primary key,
        name        text        not null,
        file        text        not null,
        mime        text        not null,
        ts         datetime     DEFAULT CURRENT_TIMESTAMP,
        caption     text        not null
);
