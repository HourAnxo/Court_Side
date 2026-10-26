package com.example.basketball.DTO;

import com.example.basketball.Entity.Team;

public record TeamDto(
        Long id,
        String name,
        String fullName,
        String abbreviation,
        String city,
        String logoUrl
) {
    public static TeamDto from(Team team) {
        return new TeamDto(
                team.getId(),
                team.getName(),
                team.getFullName(),
                team.getAbbreviation(),
                team.getCity(),
                team.getLogoUrl()
        );
    }
}