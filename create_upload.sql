create table upload (
        id          integer     primary key,
        name        text        not null,
        file        text        not null,
        mime        text        not null,
        ts         datetime     not null,
        caption     text        not null
);
