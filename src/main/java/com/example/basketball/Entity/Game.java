package com.example.basketball.Entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "games")
@Getter
@Setter
@NoArgsConstructor
public class Game {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "external_id", nullable = false, unique = true)
    private Long externalId;

    @Column(nullable = false)
    private Integer season;

    @Column(name = "game_date", nullable = false)
    private LocalDate gameDate;

    @Column(name = "start_time")
    private LocalDateTime startTime;      // stored in UTC

    private String status;                // display text, e.g. "Final"

    @Column(name = "status_state", nullable = false)
    private String statusState;           // logic value, e.g. "final"

    private Integer period;               // 1-4 = quarters, 5 = OT1 ...

    @Column(name = "game_clock")
    private String gameClock;

    @Column(nullable = false)
    private Boolean postseason = false;

    @Column(nullable = false)
    private Boolean postponed = false;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "home_team_id", nullable = false)
    private Team homeTeam;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "visitor_team_id", nullable = false)
    private Team visitorTeam;

    @Column(name = "home_score")
    private Integer homeScore;

    @Column(name = "visitor_score")
    private Integer visitorScore;

    @Column(name = "home_q1") private Integer homeQ1;
    @Column(name = "home_q2") private Integer homeQ2;
    @Column(name = "home_q3") private Integer homeQ3;
    @Column(name = "home_q4") private Integer homeQ4;
    @Column(name = "home_ot1") private Integer homeOt1;
    @Column(name = "home_ot2") private Integer homeOt2;
    @Column(name = "home_ot3") private Integer homeOt3;

    @Column(name = "visitor_q1") private Integer visitorQ1;
    @Column(name = "visitor_q2") private Integer visitorQ2;
    @Column(name = "visitor_q3") private Integer visitorQ3;
    @Column(name = "visitor_q4") private Integer visitorQ4;
    @Column(name = "visitor_ot1") private Integer visitorOt1;
    @Column(name = "visitor_ot2") private Integer visitorOt2;
    @Column(name = "visitor_ot3") private Integer visitorOt3;

    @Column(name = "created_at", insertable = false, updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at", insertable = false, updatable = false)
    private LocalDateTime updatedAt;
}