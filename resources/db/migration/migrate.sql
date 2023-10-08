-- TODO: tool to migrate the db

-- Migration script
CREATE TABLE IF NOT EXIST company (
    id TEXT NOT NULL,
    name VARCHAR UNIQUE,
    description TEXT,
    location VARCHAR,
    website VARCHAR,
    logo VARCHAR,
    industry VARCHAR,
    established DATE,
    other_details TEXT,

    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXIST user_role (
    id ENUM NOT NULL,

    PRIMARY KEY (id)
);

INSERT INTO user_role (id) VALUES ('intern'), ('alumnus'), ('admin');

CREATE TABLE IF NOT EXIST user (
    id TEXT NOT NULL,
    first_name VARCHAR,
    last_name VARCHAR,
    email VARCHAR UNIQUE NOT NULL,
    password_hash VARCHAR NOT NULL,
    role ENUM NOT NULL,
    profile_picture VARCHAR,
    bio TEXT,

    PRIMARY KEY (id),
    INDEX (role),

    FOREIGN KEY (role)
        REFERENCES user_role (id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXIST story_status (
    id ENUM NOT NULL,

    PRIMARY KEY (id)
);

INSERT INTO story_status (id) VALUES ('pending'), ('published');

CREATE TABLE IF NOT EXIST story (
    id TEXT NOT NULL,
    company_id TEXT NOT NULL,
    user_id TEXT NOT NULL,
    title VARCHAR,
    content TEXT,
    posted DATETIME,
    likes INTEGER DEFAULT 0,
    status ENUM NOT NULL,

    PRIMARY KEY (id),
    INDEX (company_id),
    INDEX (user_id),

    FOREIGN KEY (company_id)
        REFERENCES company (id)
        ON UPDATE CASCADE ON DELETE CASCADE,

    FOREIGN KEY (user_id)
        REFERENCES user (id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXIST comment (
    id TEXT NOT NULL,
    story_id TEXT NOT NULL,
    user_id TEXT NOT NULL,
    content TEXT,
    date_posted DATETIME,

    PRIMARY KEY (id),
    INDEX (story_id),
    INDEX (user_id),

    FOREIGN KEY (story_id)
        REFERENCES story (id)
        ON UPDATE CASCADE ON DELETE CASCADE,

    FOREIGN KEY (user_id)
        REFERENCES user (id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXIST tag (
    id TEXT NOT NULL,
    name VARCHAR,

    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXIST story_tag (
    story_id TEXT NOT NULL,
    tag_id TEXT NOT NULL,

    INDEX (story_id),
    INDEX (tag_id),

    FOREIGN KEY story_id
        REFERENCES story (id)
        ON UPDATE CASCADE ON DELETE CASCADE,

    FOREIGN KEY tag_id
        REFERENCES tag (id)
        ON UPDATE CASCADE ON DELETE CASCADE
);
