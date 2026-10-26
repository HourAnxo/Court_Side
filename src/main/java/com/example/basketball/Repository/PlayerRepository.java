package com.example.basketball.Repository;

import com.example.basketball.Entity.Player;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface PlayerRepository extends JpaRepository<Player, Long> {

    Optional<Player> findByExternalId(Integer externalId);

    List<Player> findByTeamId(Long teamId);
}