package com.example.basketball.DTO;

import com.example.basketball.Entity.Player;

public record PlayerDto(
        Long id,
        String firstName,
        String lastName,
        String position,
        String height,
        String weight,
        String jerseyNumber,
        String country,
        String college,
        Integer draftYear,
        Integer draftRound,
        Integer draftNumber,
        String photoUrl,
        TeamDto team
) {
    public static PlayerDto from(Player player) {
        return new PlayerDto(
                player.getId(),
                player.getFirstName(),
                player.getLastName(),
                player.getPosition(),
                player.getHeight(),
                player.getWeight(),
                player.getJerseyNumber(),
                player.getCountry(),
                player.getCollege(),
                player.getDraftYear(),
                player.getDraftRound(),
                player.getDraftNumber(),
                player.getPhotoUrl(),
                player.getTeam() == null ? null : TeamDto.from(player.getTeam())
        );
    }
}