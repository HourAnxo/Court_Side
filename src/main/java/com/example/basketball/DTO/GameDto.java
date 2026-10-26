package com.example.basketball.DTO;

import com.example.basketball.Entity.Game;

import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneOffset;

public record GameDto(
        Long id,
        Integer season,
        LocalDate gameDate,
        Instant startTime,
        String status,
        String statusState,
        Integer period,
        String gameClock,
        Boolean postseason,
        TeamDto homeTeam,
        TeamDto visitorTeam,
        Integer homeScore,
        Integer visitorScore
) {
    public static GameDto from(Game game) {
        return new GameDto(
                game.getId(),
                game.getSeason(),
                game.getGameDate(),
                game.getStartTime() == null ? null : game.getStartTime().toInstant(ZoneOffset.UTC),
                game.getStatus(),
                game.getStatusState(),
                game.getPeriod(),
                game.getGameClock(),
                game.getPostseason(),
                TeamDto.from(game.getHomeTeam()),
                TeamDto.from(game.getVisitorTeam()),
                game.getHomeScore(),
                game.getVisitorScore()
        );
    }
}