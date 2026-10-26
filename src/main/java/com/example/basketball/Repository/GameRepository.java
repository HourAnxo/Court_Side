package com.example.basketball.Repository;

import com.example.basketball.Entity.Game;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface GameRepository extends JpaRepository<Game, Long> {

    Optional<Game> findByExternalId(Long externalId);

    @EntityGraph(attributePaths = {"homeTeam", "visitorTeam"})
    List<Game> findByGameDateOrderByStartTimeAsc(LocalDate gameDate);

    @EntityGraph(attributePaths = {"homeTeam", "visitorTeam"})
    List<Game> findByStatusState(String statusState);
}