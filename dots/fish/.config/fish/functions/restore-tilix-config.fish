function restore-tilix-config
    dconf load /com/gexperts/Tilix/ < ~/.config/fish/tilix.dconf
end
