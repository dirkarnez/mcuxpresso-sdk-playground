
ExternalMCUXProject_Add(
        APPLICATION hello_world_primary_core
        SOURCE_DIR  ../primary
        board ${SB_CONFIG_secondary_board}
        core_id ${SB_CONFIG_secondary_core_id}
        config ${SB_CONFIG_secondary_config}
        toolchain ${SB_CONFIG_secondary_toolchain}
)
