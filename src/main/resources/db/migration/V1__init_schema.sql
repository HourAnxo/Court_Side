CREATE TABLE teams (
                       id            BIGINT AUTO_INCREMENT PRIMARY KEY,
                       external_id   INT NOT NULL,
                       city          VARCHAR(100),
                       name          VARCHAR(100) NOT NULL,
                       full_name     VARCHAR(150) NOT NULL,
                       abbreviation  VARCHAR(10),
                       conference    VARCHAR(20),
                       division      VARCHAR(30),
                       logo_url      VARCHAR(500),
                       created_at    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                       updated_at    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                       CONSTRAINT uq_teams_external_id UNIQUE (external_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE players (
                         id             BIGINT AUTO_INCREMENT PRIMARY KEY,
                         external_id    INT NOT NULL,
                         first_name     VARCHAR(100) NOT NULL,
                         last_name      VARCHAR(100) NOT NULL,
                         position       VARCHAR(10),
                         height         VARCHAR(10),
                         weight         VARCHAR(10),
                         jersey_number  VARCHAR(5),
                         country        VARCHAR(100),
                         college        VARCHAR(150),
                         draft_year     INT,
                         draft_round    INT,
                         draft_number   INT,
                         photo_url      VARCHAR(500),
                         team_id        BIGINT NULL,
                         created_at     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                         updated_at     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                         CONSTRAINT uq_players_external_id UNIQUE (external_id),
                         CONSTRAINT fk_players_team FOREIGN KEY (team_id) REFERENCES teams(id),
                         INDEX idx_players_team (team_id),
                         INDEX idx_players_last_name (last_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE games (
                       id                 BIGINT AUTO_INCREMENT PRIMARY KEY,
                       external_id        BIGINT NOT NULL,
                       season             INT NOT NULL,
                       game_date          DATE NOT NULL,
                       start_time         DATETIME NULL,
                       status             VARCHAR(30),
                       status_state       VARCHAR(20) NOT NULL,
                       current_period INT NULL,
                       game_clock         VARCHAR(20),
                       postseason         BOOLEAN NOT NULL DEFAULT FALSE,
                       postponed          BOOLEAN NOT NULL DEFAULT FALSE,
                       home_team_id       BIGINT NOT NULL,
                       visitor_team_id    BIGINT NOT NULL,
                       home_score         INT,
                       visitor_score      INT,
                       home_q1 INT, home_q2 INT, home_q3 INT, home_q4 INT,
                       home_ot1 INT, home_ot2 INT, home_ot3 INT,
                       visitor_q1 INT, visitor_q2 INT, visitor_q3 INT, visitor_q4 INT,
                       visitor_ot1 INT, visitor_ot2 INT, visitor_ot3 INT,
                       created_at         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                       updated_at         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                       CONSTRAINT uq_games_external_id UNIQUE (external_id),
                       CONSTRAINT fk_games_home_team    FOREIGN KEY (home_team_id)    REFERENCES teams(id),
                       CONSTRAINT fk_games_visitor_team FOREIGN KEY (visitor_team_id) REFERENCES teams(id),
                       INDEX idx_games_game_date (game_date),
                       INDEX idx_games_status_state (status_state),
                       INDEX idx_games_season (season),
                       INDEX idx_games_home_team (home_team_id),
                       INDEX idx_games_visitor_team (visitor_team_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE player_game_stats (
                                   id             BIGINT AUTO_INCREMENT PRIMARY KEY,
                                   game_id        BIGINT NOT NULL,
                                   player_id      BIGINT NOT NULL,
                                   team_id        BIGINT NOT NULL,
                                   minutes        VARCHAR(10),
                                   points         INT,
                                   rebounds       INT,
                                   offensive_reb  INT,
                                   defensive_reb  INT,
                                   assists        INT,
                                   steals         INT,
                                   blocks         INT,
                                   turnovers      INT,
                                   personal_fouls INT,
                                   fg_made        INT,
                                   fg_attempted   INT,
                                   fg3_made       INT,
                                   fg3_attempted  INT,
                                   ft_made        INT,
                                   ft_attempted   INT,
                                   plus_minus     INT,
                                   created_at     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                   updated_at     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                   CONSTRAINT uq_stats_game_player UNIQUE (game_id, player_id),
                                   CONSTRAINT fk_stats_game   FOREIGN KEY (game_id)   REFERENCES games(id)   ON DELETE CASCADE,
                                   CONSTRAINT fk_stats_player FOREIGN KEY (player_id) REFERENCES players(id),
                                   CONSTRAINT fk_stats_team   FOREIGN KEY (team_id)   REFERENCES teams(id),
                                   INDEX idx_stats_player (player_id),
                                   INDEX idx_stats_team (team_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE standings (
                           id               BIGINT AUTO_INCREMENT PRIMARY KEY,
                           season           INT NOT NULL,
                           team_id          BIGINT NOT NULL,
                           wins             INT NOT NULL DEFAULT 0,
                           losses           INT NOT NULL DEFAULT 0,
                           conference_rank  INT,
                           division_rank    INT,
                           home_record      VARCHAR(10),
                           road_record      VARCHAR(10),
                           updated_at       DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                           CONSTRAINT uq_standings_season_team UNIQUE (season, team_id),
                           CONSTRAINT fk_standings_team FOREIGN KEY (team_id) REFERENCES teams(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE users (
                       id             BIGINT AUTO_INCREMENT PRIMARY KEY,
                       email          VARCHAR(255) NOT NULL,
                       password_hash  VARCHAR(255) NOT NULL,
                       display_name   VARCHAR(100),
                       role           VARCHAR(20) NOT NULL DEFAULT 'USER',
                       enabled        BOOLEAN NOT NULL DEFAULT TRUE,
                       created_at     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                       updated_at     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                       CONSTRAINT uq_users_email UNIQUE (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE favorite_teams (
                                user_id     BIGINT NOT NULL,
                                team_id     BIGINT NOT NULL,
                                created_at  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                PRIMARY KEY (user_id, team_id),
                                CONSTRAINT fk_favteams_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
                                CONSTRAINT fk_favteams_team FOREIGN KEY (team_id) REFERENCES teams(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE favorite_players (
                                  user_id     BIGINT NOT NULL,
                                  player_id   BIGINT NOT NULL,
                                  created_at  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                  PRIMARY KEY (user_id, player_id),
                                  CONSTRAINT fk_favplayers_user   FOREIGN KEY (user_id)   REFERENCES users(id)   ON DELETE CASCADE,
                                  CONSTRAINT fk_favplayers_player FOREIGN KEY (player_id) REFERENCES players(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE device_tokens (
                               id          BIGINT AUTO_INCREMENT PRIMARY KEY,
                               user_id     BIGINT NOT NULL,
                               token       VARCHAR(500) NOT NULL,
                               platform    VARCHAR(20) NOT NULL DEFAULT 'ANDROID',
                               created_at  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                               updated_at  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                               CONSTRAINT uq_device_tokens_token UNIQUE (token(255)),
                               CONSTRAINT fk_device_tokens_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
                               INDEX idx_device_tokens_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

