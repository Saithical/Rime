--Utility scripts I've gathered up over the years. Some are useless, some are repetitve, who knows anymore! I just c/p them into every sytem.

function rime_display_config_colors()

    for k,v in pairs(rime.saved.echo_colors) do
        if rime.saved.echo_colors[k].parenthesis then
            cecho("\n<white>Your current display settings for <"..rime.saved.echo_colors[k].title..">"..k.."<white> are:")
            cecho("\n")
            cecho("\n<"..rime.saved.echo_colors[k].parenthesis..">\(<"..rime.saved.echo_colors[k].title..">Title<"..rime.saved.echo_colors[k].parenthesis..">\)<white> Message!")
            cecho("\n")
        else
            cecho("\n<white>Your current display settings for "..k.." are <"..rime.saved.echo_colors[k].title..">"..k)
            cecho("\n")
        end
    end

end

function rime_initial_setup()
    rime_save_create()
  cecho([[
<dodger_blue>Welcome to Rime!
  
<white>Running setup procedure now! Please hold.
  ]])
  
  tmpSep = tempTrigger("Your config separator will now be: '&&'.", function() rime.saved.separator = "&&" end, 1)
  tmpAdder = tempTrigger("FirstAid will no longer attempt to RIP CARD FROM BODY.", function() rime_help("help") end, 1)
  sendAll("config separator &&", "config echoqueue on", "config pagelength 150", "config wrapwidth 0", "config affliction_view full", "config simple_diag on", "config curemsgs default", "config combatmessages on", "config auto_outc on")
  rime.firstaid = false
  sendAll("firstaid curing off","firstaid defence off","firstaid reporting off","firstaid heal health off","firstaid heal mana off","firstaid use anabiotic off","firstaid use tree off","firstaid use focus off","firstaid use renew off","firstaid use clot off","firstaid adder 0")
end

function rime_save_create()
rime.saved = {
  mindseye = false,
  goggles = 0,
  mount = "none",
  allies = {
    "Mjoll",
    "Mazzion",
    "Fezzix",
    "Rhyot",
    "Bulrok",
    "Rijetta",
    "Didi",
  },
  lifesense = false,
  mana_boon = false,
  affColors = {
    writhe_necklock = "<white>writhe_necklock",
    left_arm_missing = "<white>left_arm_missing",
    right_leg_numbed = "<white>right_leg_numbed",
    epilepsy = "<blue>epilepsy",
    writhe_impaled = "<white>writhe_impaled",
    left_leg_bruised_moderate = "<white>left_leg_bruised_moderate",
    weariness = "<red>weariness",
    sandrot = "<MediumPurple>sandrot",
    houndmark = "<gold>houndmark",
    right_arm_damaged = "<white>right_arm_damaged",
    shadowbrand = "<white>shadowbrand",
    commitment_fear = "<DodgerBlue>commitment_fear",
    mental_fatigue = "<white>mental_fatigue",
    forestbrand = "<white>forestbrand",
    head_mangled = "<white>head_mangled",
    blackout = "<white>blackout",
    slickness2 = "<white>slickness2",
    crippled_throat = "<white>crippled_throat",
    vitalbane = "<white>vitalbane",
    oiled = "<white>oiled",
    haemophilia = "<brown>haemophilia",
    blind = "<white>blind",
    writhe_ropes = "<white>writhe_ropes",
    burntskin = "<white>burntskin",
    merciful = "<DodgerBlue>merciful",
    addiction = "<light_coral>addiction",
    head_bruised = "<white>head_bruised",
    magnanimity = "<white>magnanimity",
    ripped_spleen = "<white>ripped_spleen",
    heartflutter = "<MediumPurple>heartflutter",
    paresis = "<MediumPurple>paresis",
    crushed_chest = "<white>crushed_chest",
    aeon = "<sea_green>aeon",
    writhe_transfix = "<white>writhe_transfix",
    hubris = "<goldenrod>hubris",
    broken_arms = "<white>broken_arms",
    penance = "<white>penance",
    berserking = "<DodgerBlue>berserking",
    left_leg_bruised = "<white>left_leg_bruised",
    lovers_effect = "<goldenrod>lovers_effect",
    claustrophobia = "<DodgerBlue>claustrophobia",
    left_arm_damaged = "<white>left_arm_damaged",
    numb_arms = "<white>numb_arms",
    pre_restore_torso = "<white>pre_restore_torso",
    left_arm_numbed = "<white>left_arm_numbed",
    mirroring = "<MediumPurple>mirroring",
    mindclamped = "<white>mindclamped",
    indifference = "<white>indifference",
    shyness = "<blue>shyness",
    blighted = "<light_coral>blighted",
    impairment = "<red>impairment",
    void = "<white>void",
    right_arm_dislocated = "<white>right_arm_dislocated",
    right_leg_bruised_moderate = "<white>right_leg_bruised_moderate",
    deaf = "<white>deaf",
    hypersomnia = "<light_coral>hypersomnia",
    generosity = "<goldenrod>generosity",
    hepafarin = "<white>hepafarin",
    stormtouched = "<white>stormtouched",
    confusion = "<light_coral>confusion",
    slickness = "<gold>slickness",
    vertigo = "<DodgerBlue>vertigo",
    superstition = "<goldenrod>superstition",
    body_odor = "<brown>body_odor",
    writhe_thighlock = "<white>writhe_thighlock",
    right_arm_amputated = "<white>right_arm_amputated",
    accursed = "<goldenrod>accursed",
    right_leg_amputated = "<white>right_leg_amputated",
    left_leg_missing = "<white>left_leg_missing",
    prone = "<red>PRONE",
    soul_disease = "<gold>disease",
    head_bruised_moderate = "<white>head_bruised_moderate",
    amnesia = "<white>amnesia",
    density = "<white>density",
    sadness = "<light_coral>sadness",
    pre_restore_head = "<white>pre_restore_head",
    right_arm_bruised_critical = "<white>right_arm_bruised_critical",
    phlegm = "<white>phlegm",
    burnt_eyes = "<white>burnt_eyes",
    shadowcoat = "<white>shadowcoat",
    speed = "<white>speed",
    disrupted = "<white>disrupted",
    left_leg_bruised_critical = "<white>left_leg_bruised_critical",
    deadening = "<sea_green>deadening",
    nyctophobia = "<DodgerBlue>nyctophobia",
    right_leg_bruised_critical = "<white>right_leg_bruised_critical",
    stiffness = "<white>stiffness",
    sore_ankle = "<white>sore_ankle",
    right_leg_missing = "<white>right_leg_missing",
    writhe_web = "<white>writhe_web",
    deepwound = "<white>deepwound",
    ringing_ears = "<red>ringing_ears",
    hypochondria = "<red>hypochondria",
    hallucinations = "<light_coral>hallucinations",
    left_leg_dislocated = "<white>left_leg_dislocated",
    torso_bruised_moderate = "<white>torso_bruised_moderate",
    justice = "<white>justice",
    disturb_sanity = "<white>disturb_sanity",
    muscle_spasms = "<white>muscle_spasms",
    anorexia = "<white>anorexia",
    no_deaf = "<white>no_deaf",
    petrified = "<white>petrified",
    whiplash = "<white>whiplash",
    premonition = "<white>premonition",
    fear = "<white>fear",
    spiritbrand = "<white>spiritbrand",
    selfpity = "<blue>selfpity",
    quicksand = "<white>quicksand",
    bloodlust = "<white>bloodlust",
    battle_hunger = "<white>battle_hunger",
    impatience = "<blue>impatience",
    pre_restore_right_leg = "<white>pre_restore_right_leg",
    right_leg_broken = "<white>right_leg_broken",
    wraith = "<gold>wraith",
    left_leg_damaged = "<white>left_leg_damaged",
    windbrand = "<white>windbrand",
    frozenfeet = "<white>frozenfeet",
    gorged = "<white>gorged",
    shaderot_body = "<deep_sky_blue>shaderot_body",
    levitation = "<white>levitation",
    writhe_vines = "<white>writhe_vines",
    shivering = "<white>shivering",
    left_leg_numbed = "<white>left_leg_numbed",
    attuned = "<white>attuned",
    dissonance = "<blue>dissonance",
    right_arm_mangled = "<white>right_arm_mangled",
    idiocy = "<cyan>idiocy",
    pre_restore_left_arm = "<white>pre_restore_left_arm",
    masochism = "<DodgerBlue>masochism",
    destroyed_throat = "<white>destroyed_throat",
    ripped_throat = "<white>ripped_throat",
    withering = "<gold>withering",
    peace = "<goldenrod>peace",
    stupidity = "<blue>stupidity",
    right_leg_damaged = "<white>right_leg_damaged",
    torso_elevation = "<white>torso_elevation",
    agoraphobia = "<DodgerBlue>agoraphobia",
    dementia = "<light_coral>dementia",
    paranoia = "<light_coral>paranoia",
    crippled = "<MediumPurple>crippled",
    broken_legs = "<white>broken_legs",
    right_arm_bruised = "<white>right_arm_bruised",
    right_arm_numbed = "<white>right_arm_numbed",
    blurry_vision = "<white>blurry_vision",
    lightwound = "<white>lightwound",
    wasting = "<white>wasting",
    spiritbane = "<white>spiritbane",
    troubledbreathing = "<white>troubledbreathing",
    instawake = "<white>instawake",
    right_leg_dislocated = "<white>right_leg_dislocated",
    asleep = "<white>asleep",
    mental_disruption = "<brown>mental_disruption",
    rebounding = "<firebrick>rebounding",
    disturb_confidence = "<white>disturb_confidence",
    chest = "<white>chest",
    pacifism = "<goldenrod>pacifism",
    blisters = "<MediumPurple>blisters",
    writhe_grappled = "<white>writhe_grappled",
    cracked_ribs = "<white>cracked_ribs",
    shaderot_benign = "<deep_sky_blue>shaderot_benign",
    recklessness = "<DodgerBlue>recklessness",
    emberbrand = "<white>emberbrand",
    heatspear = "<white>heatspear",
    blood = "<white>blood",
    infested = "<blue>infested",
    head_damaged = "<white>head_damaged",
    left_arm_bruised = "<white>left_arm_bruised",
    ablaze = "<white>ablaze",
    shaderot_wither = "<deep_sky_blue>shaderot_wither",
    writhe_bind = "<white>writhe_bind",
    stonevice = "<white>stonevice",
    right_arm_bruised_moderate = "<white>right_arm_bruised_moderate",
    venom_resistance = "<white>venom_resistance",
    resin_glauxe = "<white>resin_glauxe",
    left_arm_mangled = "<white>left_arm_mangled",
    exhausted = "<brown>exhausted",
    yellowbile = "<white>yellowbile",
    thin_blood = "<brown>thin_blood",
    left_arm_broken = "<white>left_arm_broken",
    left_arm_bruised_critical = "<white>left_arm_bruised_critical",
    right_arm_broken = "<white>right_arm_broken",
    collapsed_lung = "<white>collapsed_lung",
    left_leg_broken = "<white>left_leg_broken",
    writhe_armpitlock = "<white>writhe_armpitlock",
    head_bruised_critical = "<white>head_bruised_critical",
    faintness = "<blue>faintness",
    mistbrand = "<white>mistbrand",
    allergies = "<brown>allergies",
    voidgaze = "<white>voidgaze",
    hatred = "<light_coral>hatred",
    stonebrand = "<white>stonebrand",
    smashed_throat = "<white>smashed_throat",
    blood_curse = "<light_coral>blood_curse",
    selarnia = "<white>selarnia",
    shaderot_spirit = "<deep_sky_blue>shaderot_spirit",
    conviction = "<white>conviction",
    loneliness = "<DodgerBlue>loneliness",
    frozen = "<white>frozen",
    dizziness = "<blue>dizziness",
    physical_disruption = "<brown>physical_disruption",
    broken_any = "<white>broken_any",
    mauledface = "<white>mauledface",
    backstrain = "<white>backstrain",
    rend = "<brown>rend",
    plodding = "<cyan>plodding",
    weakvoid = "<white>weakvoid",
    insulation = "<white>insulation",
    soul_poison = "<gold>POISON",
    disturb_inhibition = "<white>disturb_inhibition",
    sensitivity = "<red>sensitivity",
    left_leg_mangled = "<white>left_leg_mangled",
    patterns = "<deep_sky_blue>patterns",
    laxity = "<goldenrod>laxity",
    resonance = "<blue>resonance",
    effused_blood = "<white>effused_blood",
    baldness = "<red>baldness",
    torso_bruised_critical = "<white>torso_bruised_critical",
    disfigurement = "<gold>disfigurement",
    crippled_body = "<MediumPurple>crippled_body",
    left_arm_amputated = "<white>left_arm_amputated",
    right_arm_missing = "<white>right_arm_missing",
    pre_restore_left_leg = "<white>pre_restore_left_leg",
    stun = "<white>stun",
    limp_veins = "<white>limp_veins",
    sore_wrist = "<white>sore_wrist",
    clumsiness = "<red>clumsiness",
    lethargy = "<brown>lethargy",
    torso_damaged = "<white>torso_damaged",
    omen = "<white>omen",
    ripped_groin = "<white>ripped_groin",
    hypothermia = "<white>hypothermia",
    waterbreathing = "<white>waterbreathing",
    spinal_rip = "<white>spinal_rip",
    hellsight = "<sea_green>hellsight",
    left_arm_bruised_moderate = "<white>left_arm_bruised_moderate",
    vinethorns = "<white>vinethorns",
    pre_restore_right_arm = "<white>pre_restore_right_arm",
    weak_grip = "<white>weak_grip",
    vomiting = "<brown>vomiting",
    lifebane = "<white>lifebane",
    agony = "<goldenrod>agony",
    shaderot_heat = "<deep_sky_blue>shaderot_heat",
    torso_bruised = "<white>torso_bruised",
    unconscious = "<white>unconscious",
    disturb_impulse = "<white>disturb_impulse",
    torso_mangled = "<white>torso_mangled",
    left_arm_dislocated = "<white>left_arm_dislocated",
    gloom = "<white>gloom",
    paralysis = "<MediumPurple>paralysis",
    thorns = "<white>thorns",
    right_leg_mangled = "<white>right_leg_mangled",
    mob_impaled = "<white>mob_impaled",
    voyria = "<white>voyria",
    fire_elevation = "<white>fire_elevation",
    right_leg_bruised = "<white>right_leg_bruised",
    blood_poison = "<red>blood_poison",
    muddled = "<white>muddled",
    squelched = "<gold>squelched",
    left_leg_amputated = "<white>left_leg_amputated",
    asthma = "<red>asthma",
    stuttering = "<white>stuttering",
    migraine = "<gold>migraine"
  },
  echo_colors = {
    ["pvp"] = {
        ["parenthesis"] = "RoyalBlue",
        ["title"] = "DeepSkyBlue",
    },
    ["pve"] = {
        ["parenthesis"] = "DeepPink",
        ["title"] = "LightSeaGreen",
    },
    ["def"] = {
        ["parenthesis"] = "MediumPurple",
        ["title"] = "LawnGreen",
    },
    ["curing"] = {
        ["parenthesis"] = "magenta",
        ["title"] = "SteelBlue",
    },
    ["order"] = {
        ["parenthesis"] = "DarkSlateGrey",
        ["title"] = "a_green",
    },
    ["war"] = {
        ["parenthesis"] = "NavyBlue",
        ["title"] = "a_darkmagenta",
    },
    ["tca"] = {
        --target cured aff color
        ["title"] = "DarkOrchid"
    },
    ["tga"] = {
        --target gained aff color
        ["title"] = "violet",
    },
    ["target"] = {
        --target color
        ["title"] = "DodgerBlue",
    }
  },
  separator = "&&",
  gag_command = true,
  stable = "bloodlochstable",
  stability = false,
  arti_pipes = false
}
table.save(getMudletHomeDir().."/rime.saved.lua", rime.saved)
end

function rime_help(type)

  type = type:lower()
  local hit_one = false
  
  if type == "setup" then
  hit_one = true
  cecho([[<dodger_blue>

<red>     sload
<white>      - Load the system after making changes to any .lua file.
<red>     set sep <separator>
<white>      - Set the system separator to anything you want.
<red>     set mount <mount id number>
<white>      - Tell the system which mount is yours.
<red>     set stable <stable>
<white>      - Tell the system which stable you'd like to store your mounts in.
<red>     rime gag send <yes/no>
<white>      - Gag the text sent by the system to Aetolia.
<red>     save
<white>      - Save your settings.
  ]])
  end
  
  if type == "pk" then
  hit_one = true
  cecho([[<dodger_blue>
  Rime comes with a couple of pvp routes for most shadow classes!
  
<red>     rll
<white>      - List available routes for your current class.
<red>     rs <route>
<white>      - Switch to your chosen <route>.
<red>     ai
<white>      - Toggle the offense on and off.
<red>     tc
<white>      - Clear target afflictions.
<red>     reset
<white>      - Reset your afflictions.
<red>     wl <leader>
<white>      - Tell the system who to take targets calls from.
<red>     wro
<white>      - Toggle affliction web reporting.
<red>     wco
<white>      - Toggle web target calling.
<red>     woff
<white>      - Turn off all web calling, clear web listening.
<red>     sat
<white>      - Toggle automatic target swapping for group fights.
<red>     atl <list of targets>
<white>      - Set, and add to, a list of targets for automatic target swapping.
<red>     atp <target> <priority>
<white>      - Move a specific target around in the target list.
<red>     atr <target>
<white>      - Remove someone from the target list.
<red>     atlc
<white>      - Clear the target list.
<red>     ?]]..gmcp.Char.Status.class:lower()..[[ 
<white>      - ]]..gmcp.Char.Status.class..[[ specific aliases!
  ]])
  
  end
  
  if type == "bashing" then
  hit_one = true
  cecho([[dodger_blue
  Rime has a simple basher with paths for many zones! Included in this is an area exploration function.
<red>     ba on
<white>      - If you're in a zone with a mapped out path it will walk around and automatically try to kill everything in the zone.
<white>      - The zone may not be mapped out, but the basher will still attack NPCs if they're in the bashing system.
<red>     ba bot
<white>      - Starting in Drakuum this will complete a simple circuit through a few zones, killing everything in the zone.
<red>     ba off
<white>      - Turn the basher off.
<red>     ba explore
<white>      - Will try its very hardest to visit every room in an area.
<red>     group <person>
<white>      - Add someone to your bashing group, this will let the basher attack NPCs in the same room as them.
  ]])
  end
  
  if type == "curing" then
  hit_one = true
  cecho([[<dodger_blue>
  Rime comes standard with client side curing which utilizes the queueing system, it is also compatible with FirstAid.
  
<red>     fa
<white>      - Toggle between client side curing and using FirstAid.
<red>     cs <cure set>
<white>      - Manually set which curing priority you want to use. Options are Default, Group, and any class.
  ]])
  
  end
  
  if type == "system" then
  hit_one = true
  cecho([[<dodger_blue>
  Various system functions.
  
<red>     pause
<white>      - Pause the system.
<red>     unpause
<white>      - Unpause the system.
<red>     rime ally <person>
<white>      - Add someone as a system ally, this has a few effects including using disperse, and support abilities in combat.
<red>     rime unally <person>
<white>      - Remove someone as an ally to the system.
<red>     rime allies
<white>      - List all system allies.
  ]])
  end
  
  if type == "artifacts" then
  hit_one = true
  local subit = {["true"] = "(active)", ["false"] = "(not active)", ["nil"] = "(not active)",}
  cecho([[<dodger_blue>
  Rime can account for a lot of artifacts, including Antiquated Artifacts!
  
<red>     rime arti pipes <yes/no> <green>]]..(subit[tostring(rime.saved.arti_pipes)])..[[ 
<white>      - Set to "yes" if you have 3 artifact pipes.
<red>     rime arti mass <yes/no> <green>]]..(subit[tostring(rime.saved.stability)])..[[ 
<white>      - Set to "yes" if you have the stability artifact power.
<red>     rime arti manaboon <yes/no> <green>]]..(subit[tostring(rime.saved.mana_boon)])..[[ 
<white>      - Set to "yes" if you have the mana_boon artifact power.
<red>     rime arti lifesense <yes/no> <green>]]..(subit[tostring(rime.saved.lifesense)])..[[ 
<white>      - Set to "yes" if you have the lifesense relic.
<red>     rime arti mindseye <yes/no> <green>]]..(subit[tostring(rime.saved.mindseye)])..[[ 
<white>      - Set to "yes" if you have BOTH the antenna and blindfold relics.
<red>     rime arti goggles <level number> <green>]]..tostring(rime.saved.goggles)..[[ 
<white>      - Antiquated Artifact goggles levels 1-20 fully supported.
<red>     rime arti webspray <yes/no> <green>]]..(subit[tostring(rime.saved.webspray)])..[[ 
<white>      - Set to "yes" if you have the webspray relic.
<red>     rime arti lifevision <yes/no> <green>]]..(subit[tostring(rime.saved.lifevision)])..[[ 
<white>      - Set to "yes" if you have the lifevision artifact.
<red>     rime arti bracer <yes/no> <green>]]..(subit[tostring(rime.saved.bracer)])..[[ 
<white>      - Set to "yes" if you have the combined_powers bracer relic.
<red>     rime arti zephyr <yes/no> <green>]]..(subit[tostring(rime.saved.bracer)])..[[ 
<white>      - Set to "yes" if you have the zephyr artifact.

]])
  end

  if type == "customization" then
    hit_one = true
    cecho([[<dodger_blue>
    Rime's base color is dodger_blue, and supporting colors! Most can be changed!

<red>     rime color <type> <position> <color>
<white>      - <type> can be def, order, curing, pve, target, tga, tca, war, pvp
<white>           - def is defences, tga and tca are target gained/cured aff respectively
<white>      - <position> can be title or parenthesis
<white>           - tga, tca, and target do not have parenthesis entries
<white>      - <color> can be any color AS IT APPEARS when you type "colors"

<white>      - An example
<white>            rime color pvp title DeepSkyBlue
<white>            rime color pvp parenthesis RoyalBlue
<white>      - this will set the pvp echo to the system default of <RoyalBlue>(<DeepSkyBlue>PvP<RoyalBlue>)

]])
  end
  
  if type == gmcp.Char.Status.class:lower() then
    hit_one = true
    rime_class_help(type)
  end
  
  if type == "help" or not hit_one then
  cecho([[<dodger_blue>
  Welcome to Rime! Below are a list of options you can ?query for help!

<red>     ?setup
<white>      - Step through setting up things such as various supported artifacts, your mount, prefered stable, etc.
<red>     ?curing
<white>      - Explanation of how the curing is handled, and how to manipulate it.
<red>     ?pk
<white>      - How to work the offense!
<red>     ?bashing
<white>      - How to bash! Areas Supported!
<red>     ?system
<white>      - General system commands.
<red>     ?]]..gmcp.Char.Status.class:lower()..[[ 
<white>      - ]]..gmcp.Char.Status.class..[[ specific aliases or aliases.
<red>     ?artifacts
<white>      - Rime can account for some artifacts, here's how!
<red>     ?customization
<white>      - A lot of Rime's colors are customizable!
  ]])
  end
    if hit_one then rime.echo("Don't forget to <red>save<white> your options and settings!") end
end

function rime_class_help(type)
  type = type:lower()
  
  if type == "praenomen" then
  cecho([[<dodger_blue>
  Praenomen will find these aliases useful:
  
  Prae Upkeep Off
<red>     wo
<white>      -Turns off blood and endurance draining defenses. Trepidation, Blood Track, and Elusion

<dodger_blue>  Hallucinations/Mana Ent
<red>     wraith
<white>      - Raises an undead minion as the mana type, immediately mutating it to Eldritch (Gives Hallucinations)

<dodger_blue>  Paresis/HP Ent
<red>     ghast
<white>      - Raises an undead minion as the physical type, immediately mutating it to Ghastly (Gives Paresis)

<dodger_blue>  Fangbarrier/HP Ent
<red>     wight
<white>      - Raises an undead minion as the physical type, immediately mutating it to Oozing (Strips fangbarrier defense)

<dodger_blue>  Haemophilia/HP Ent
<red>     ghoul
<white>      - Raises an undead minion as the physical type, immediately mutating it to Festering (Gives Haemophilia)

<dodger_blue>  Fade
<red>     f <direction>
<white>      - Type F <DIRECTION> to attempt to Fade in a specific direction. Will automatically attempt to dismount before fading.

<dodger_blue>  Curse/Poison Setting
<red>     set <curse/poison> <#>
<white>      - Use this to set an antipsycotic stack threshold or a curing tree stack limit for use of Blood Curse and Blood Poison respectively.

<dodger_blue>  Lure
<red>     lu
<white>      - Attempts to lure your current target.
]])
  end
  
  if type == "indorani" then
  cecho([[
  Indorani will find these useful.
  
  <dodger_blue>  Empress
<red>     emp or emp <target>
<white>      - Will attempt to fling the Empress card at your current target, or whoever you specify.

<dodger_blue>  Gravehands
<red>     gh
<white>      - Summons gravehands at your current location!

<dodger_blue>  Pathfinder
<red>     op
<white>      - This kills the offenses and queues up ordering your path finder. Useful for quick get aways.

<dodger_blue>  Priestess
<red>     pr or pr <target>
<white>      - Will attempt to fling the Priestess card at your current target, or whoever you specify.

<dodger_blue>  Fool
<red>     fo or fo <target>
<white>      - Will attempt to fling the Fool card at your current target, or whoever you specify.

<dodger_blue>  Set Deform
<red>     set deform <#>
<white>      - Will set the number of afflictions you want to use Deform at. Deform will not be cast unless your target has that many or more applicable afflictions.

<dodger_blue> Lust
<red>     lu
<white>      - Attempt to lust your current target.
]])
  end
  
  if type == "carnifex" then
  cecho([[
  Carnifex will find these useful.
  
<dodger_blue>  Set Warhounds
<red>     set hound <trait> <hound name or number>
<white>      - Tell Rime which hound to use for which ability.

<dodger_blue>  Show Warhounds
<red>     show hounds
<white>      - Check which hounds you've set Rime to use with which abilities.

<dodger_blue>  Trip, Crush, Pulverize
<red>     cc
<white>      - Trip a standing opponent, crush a fallen one, pulverize a crushed one.

<dodger_blue>  Prepare to Charge
<red>     charge
<white>      - Tell the offense you would like to prepare to charge your target.

<dodger_blue>  Skewer
<red>     imp
<white>      - Interrupts the offense and attempts to skewer your target.

<dodger_blue>  Wrench
<red>     db
<white>      - Attempt to wrench whoever you have skewered.

<dodger_blue>  Pole Sweep
<red>     ps or psa
<white>      - Pole sweep everyone who has recently engaged you, or everyone in the room.

<dodger_blue>  Pole Hook
<red>     ph or ph <target>
<white>      - Will attempt to trip your target, or whoever you specify.

<dodger_blue>  Hammer Throw
<red>     ht
<white>      - Will attempt to throw your hammer at your target.

<dodger_blue>  Soul Storm
<red>     ss
<white>      - Will attempt to destroy a Shaman's familiar.

<dodger_blue>  Consume Souls
<red>     ch or cm
<white>      - Will attempt to consume souls for health or mana.
]])
  end
end

function rime_echo_colors(type, position, color)

    if rime.saved.echo_colors[type] then
        if rime.saved.echo_colors[type][position] then
            rime.saved.echo_colors[type][position] = color
            rime.echo("Color for "..type.."'s "..position.." changed to "..color)
        else
            rime.echo("This position \(<red>"..position.."<white>\) isn't a known setting!")
        end
    else
        rime.echo("This type \(<red>"..type.."<white>\) isn't a known setting!")
    end

end

function sortedKeys(t)
  local keys = {}
  for k,v in pairs(t) do
      table.insert(keys, k)
  end
  
  table.sort(keys, function(a,b)
   -- print(t[a])
    return t[a] < t[b]
  end)

  return keys
end

function returnPercent(amount, limit)
  amount = tonumber(amount)
  limit = tonumber(limit)
  return math.floor(amount / limit * 100)
end

function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

function additem(list, val, pos)

  if table.contains(list, val) then return end

    if pos then table.insert(list, pos, val) else table.insert(list, val) end

end

function delitem(array, val)
    for i, v in ipairs(array) do
        if v == val then
            table.remove(array, i)
        end
    end
end


function inTable(ctable, val)
    if not table then return false end
    return table.contains(ctable, val)
end

function mapSend(command)

    send(command)

end

function table.copy(t)
  local u = {}
  for k, v in pairs(t) do u[k] = v end
    return u
end

function removeVal(array, val)

    if not array then echo("error error error") echo("val is "..val) return end
    for i,v in ipairs(array) do
        if v == val then
            table.remove(array, i)
        end
    end
end

function table.icopy(source)
    if type(source) ~= "table" then return end
    local copy = {}

    for i, v in ipairs(source) do
        table.insert(copy, v)
    end

    return copy
end

function table.shallowcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = orig_value
        end
    else --! number, string, boolean, etc
        copy = orig
    end
    return copy
end

function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end


rime_color_table = {
        snow                  = {255, 250, 250},
        ghost_white           = {248, 248, 255},
        GhostWhite            = {248, 248, 255},
        white_smoke           = {245, 245, 245},
        WhiteSmoke            = {245, 245, 245},
        gainsboro             = {220, 220, 220},
        floral_white          = {255, 250, 240},
        FloralWhite           = {255, 250, 240},
        old_lace              = {253, 245, 230},
        OldLace               = {253, 245, 230},
        linen                 = {250, 240, 230},
        antique_white         = {250, 235, 215},
        AntiqueWhite          = {250, 235, 215},
        papaya_whip           = {255, 239, 213},
        PapayaWhip            = {255, 239, 213},
        blanched_almond       = {255, 235, 205},
        BlanchedAlmond        = {255, 235, 205},
        bisque                = {255, 228, 196},
        peach_puff            = {255, 218, 185},
        PeachPuff             = {255, 218, 185},
        navajo_white          = {255, 222, 173},
        NavajoWhite           = {255, 222, 173},
        moccasin              = {255, 228, 181},
        cornsilk              = {255, 248, 220},
        ivory                 = {255, 255, 240},
        lemon_chiffon         = {255, 250, 205},
        LemonChiffon          = {255, 250, 205},
        seashell              = {255, 245, 238},
        honeydew              = {240, 255, 240},
        mint_cream            = {245, 255, 250},
        MintCream             = {245, 255, 250},
        azure                 = {240, 255, 255},
        alice_blue            = {240, 248, 255},
        AliceBlue             = {240, 248, 255},
        lavender              = {230, 230, 250},
        lavender_blush        = {255, 240, 245},
        LavenderBlush         = {255, 240, 245},
        misty_rose            = {255, 228, 225},
        MistyRose             = {255, 228, 225},
        white                 = {255, 255, 255},
        black                 = {0, 0, 0},
        dark_slate_gray       = {47, 79, 79},
        DarkSlateGray         = {47, 79, 79},
        dark_slate_grey       = {47, 79, 79},
        DarkSlateGrey         = {47, 79, 79},
        dim_gray              = {105, 105, 105},
        DimGray               = {105, 105, 105},
        dim_grey              = {105, 105, 105},
        DimGrey               = {105, 105, 105},
        slate_gray            = {112, 128, 144},
        SlateGray             = {112, 128, 144},
        slate_grey            = {112, 128, 144},
        SlateGrey             = {112, 128, 144},
        light_slate_gray      = {119, 136, 153},
        LightSlateGray        = {119, 136, 153},
        light_slate_grey      = {119, 136, 153},
        LightSlateGrey        = {119, 136, 153},
        gray                  = {190, 190, 190},
        grey                  = {190, 190, 190},
        light_grey            = {211, 211, 211},
        LightGrey             = {211, 211, 211},
        light_gray            = {211, 211, 211},
        LightGray             = {211, 211, 211},
        midnight_blue         = {25, 25, 112},
        MidnightBlue          = {25, 25, 112},
        navy                  = {0, 0, 128},
        navy_blue             = {0, 0, 128},
        NavyBlue              = {0, 0, 128},
        cornflower_blue       = {100, 149, 237},
        donkeybrown           = {100, 78, 36},
        CornflowerBlue        = {100, 149, 237},
        dark_slate_blue       = {72, 61, 139},
        DarkSlateBlue         = {72, 61, 139},
        slate_blue            = {106, 90, 205},
        SlateBlue             = {106, 90, 205},
        medium_slate_blue     = {123, 104, 238},
        MediumSlateBlue       = {123, 104, 238},
        light_slate_blue      = {132, 112, 255},
        LightSlateBlue        = {132, 112, 255},
        medium_blue           = {0, 0, 205},
        MediumBlue            = {0, 0, 205},
        royal_blue            = {65, 105, 225},
        RoyalBlue             = {65, 105, 225},
        blue                  = {0, 0, 255},
        dodger_blue           = {30, 144, 255},
        DodgerBlue            = {30, 144, 255},
        deep_sky_blue         = {0, 191, 255},
        DeepSkyBlue           = {0, 191, 255},
        sky_blue              = {135, 206, 235},
        SkyBlue               = {135, 206, 235},
        light_sky_blue        = {135, 206, 250},
        LightSkyBlue          = {135, 206, 250},
        steel_blue            = {70, 130, 180},
        SteelBlue             = {70, 130, 180},
        light_steel_blue      = {176, 196, 222},
        LightSteelBlue        = {176, 196, 222},
        light_blue            = {173, 216, 230},
        LightBlue             = {173, 216, 230},
        powder_blue           = {176, 224, 230},
        PowderBlue            = {176, 224, 230},
        pale_turquoise        = {175, 238, 238},
        PaleTurquoise         = {175, 238, 238},
        dark_turquoise        = {0, 206, 209},
        DarkTurquoise         = {0, 206, 209},
        medium_turquoise      = {72, 209, 204},
        MediumTurquoise       = {72, 209, 204},
        turquoise             = {64, 224, 208},
        cyan                  = {0, 255, 255},
        light_cyan            = {224, 255, 255},
        LightCyan             = {224, 255, 255},
        cadet_blue            = {95, 158, 160},
        CadetBlue             = {95, 158, 160},
        medium_aquamarine     = {102, 205, 170},
        MediumAquamarine      = {102, 205, 170},
        aquamarine            = {127, 255, 212},
        dark_green            = {0, 100, 0},
        DarkGreen             = {0, 100, 0},
        dark_olive_green      = {85, 107, 47},
        DarkOliveGreen        = {85, 107, 47},
        dark_sea_green        = {143, 188, 143},
        DarkSeaGreen          = {143, 188, 143},
        sea_green             = {46, 139, 87},
        SeaGreen              = {46, 139, 87},
        medium_sea_green      = {60, 179, 113},
        MediumSeaGreen        = {60, 179, 113},
        light_sea_green       = {32, 178, 170},
        LightSeaGreen         = {32, 178, 170},
        pale_green            = {152, 251, 152},
        PaleGreen             = {152, 251, 152},
        spring_green          = {0, 255, 127},
        SpringGreen           = {0, 255, 127},
        lawn_green            = {124, 252, 0},
        LawnGreen             = {124, 252, 0},
        green                 = {0, 255, 0},
        chartreuse            = {127, 255, 0},
        medium_spring_green   = {0, 250, 154},
        MediumSpringGreen     = {0, 250, 154},
        green_yellow          = {173, 255, 47},
        GreenYellow           = {173, 255, 47},
        lime_green            = {50, 205, 50},
        LimeGreen             = {50, 205, 50},
        yellow_green          = {154, 205, 50},
        YellowGreen           = {154, 205, 50},
        forest_green          = {34, 139, 34},
        ForestGreen           = {34, 139, 34},
        olive_drab            = {107, 142, 35},
        OliveDrab             = {107, 142, 35},
        dark_khaki            = {189, 183, 107},
        DarkKhaki             = {189, 183, 107},
        khaki                 = {240, 230, 140},
        pale_goldenrod        = {238, 232, 170},
        PaleGoldenrod         = {238, 232, 170},
        light_goldenrod_yellow= {250, 250, 210},
        LightGoldenrodYellow  = {250, 250, 210},
        light_yellow          = {255, 255, 224},
        LightYellow           = {255, 255, 224},
        yellow                = {255, 255, 0},
        gold                  = {255, 215, 0},
        light_goldenrod       = {238, 221, 130},
        LightGoldenrod        = {238, 221, 130},
        goldenrod             = {218, 165, 32},
        dark_goldenrod        = {184, 134, 11},
        DarkGoldenrod         = {184, 134, 11},
        rosy_brown            = {188, 143, 143},
        RosyBrown             = {188, 143, 143},
        indian_red            = {205, 92, 92},
        IndianRed             = {205, 92, 92},
        saddle_brown          = {139, 69, 19},
        SaddleBrown           = {139, 69, 19},
        sienna                = {160, 82, 45},
        peru                  = {205, 133, 63},
        burlywood             = {222, 184, 135},
        beige                 = {245, 245, 220},
        wheat                 = {245, 222, 179},
        sandy_brown           = {244, 164, 96},
        SandyBrown            = {244, 164, 96},
        tan                   = {210, 180, 140},
        chocolate             = {210, 105, 30},
        firebrick             = {178, 34, 34},
        brown                 = {165, 42, 42},
        brightblue            = {34, 100, 220},
        dark_salmon           = {233, 150, 122},
        DarkSalmon            = {233, 150, 122},
        salmon                = {250, 128, 114},
        light_salmon          = {255, 160, 122},
        LightSalmon           = {255, 160, 122},
        orange                = {255, 165, 0},
        dark_orange           = {255, 140, 0},
        DarkOrange            = {255, 140, 0},
        coral                 = {255, 127, 80},
        light_coral           = {240, 128, 128},
        LightCoral            = {240, 128, 128},
        tomato                = {255, 99, 71},
        orange_red            = {255, 69, 0},
        OrangeRed             = {255, 69, 0},
        red                   = {255, 0, 0},
        hot_pink              = {255, 105, 180},
        HotPink               = {255, 105, 180},
        pale_red              = {255, 177, 177},
        lightred              = {255, 92, 92},
        deep_pink             = {255, 20, 147},
        DeepPink              = {255, 20, 147},
        pink                  = {255, 192, 203},
        mustard               = {255, 199, 92},
        light_pink            = {255, 182, 193},
        LightPink             = {255, 182, 193},
        pale_violet_red       = {219, 112, 147},
        PaleVioletRed         = {219, 112, 147},
        maroon                = {176, 48, 96},
        medium_violet_red     = {199, 21, 133},
        MediumVioletRed       = {199, 21, 133},
        violet_red            = {208, 32, 144},
        VioletRed             = {208, 32, 144},
        magenta               = {255, 0, 255},
        violet                = {238, 130, 238},
        plum                  = {221, 160, 221},
        orchid                = {218, 112, 214},
        medium_orchid         = {186, 85, 211},
        MediumOrchid          = {186, 85, 211},
        dark_orchid           = {153, 50, 204},
        DarkOrchid            = {153, 50, 204},
        dark_violet           = {148, 0, 211},
        DarkViolet            = {148, 0, 211},
        blue_violet           = {138, 43, 226},
        BlueViolet            = {138, 43, 226},
        purple                = {160, 32, 240},
        medium_purple         = {147, 112, 219},
        MediumPurple          = {147, 112, 219},
        thistle               = {216, 191, 216},

-- CHECK IT OUT! Aetolia colors!
        a_darkred             = {128, 0, 0},
        a_darkgreen           = {0, 179, 0},
        a_brown               = {128, 128, 0},
        a_darkblue            = {0, 0, 128},
        a_darkmagenta         = {128, 0, 128},
        a_darkcyan            = {0, 128, 128},
        a_grey                = {192, 192, 192},
        a_darkgrey            = {128, 128, 128},
        a_red                 = {255, 0, 0},
        a_green               = {0, 255, 0},
        a_yellow              = {255, 255, 0},
        a_blue                = {0, 85, 255},
        a_magenta             = {255, 0, 255},
        a_cyan                = {0, 255, 255},
        a_white               = {255, 255, 255},

        chat_bg                 = {25, 25, 25},
}

for k, v in pairs(rime_color_table) do
    if not color_table[k] then
        color_table[k] = v
    end
end

weHarvesting = false
tw = tw or {}

if file_exists(getMudletHomeDir() .. "\\shrines.lua") then
  table.load(getMudletHomeDir() .. "\\shrines.lua", tw)
else
  table.save(getMudletHomeDir() .. "\\shrines.lua", tw)
end

function shrine_capture()
  local divine =
    {
      "ethne",
      "damariel",
      "dhar",
      "chakrasul",
      "haern",
      "iosyne",
      "ivoln",
      "bamathis",
      "omei",
      "severn",
      "slyphe",
      "tanixalthas",
    }
  if gmcp.Char.Items.List.location ~= "room" then
    return false
  end
  local hasShrine = false
  local hasMonument = false
  local vnum = gmcp.Room.Info.num
  local room = gmcp.Room.Info.name
  local area = gmcp.Room.Info.area
  for i, v in ipairs(gmcp.Char.Items.List.items) do
    if v.name:find("shrine") then
      for _, god in ipairs(divine) do
        if v.name:lower():find(god) then
          hasShrine = god
          addShrine(god, vnum, room, area)
        end
      end
    end
    if v.name:find("unreal statue") or v.name:find("a monument of ") then
      for _, god in ipairs(divine) do
        if v.name:lower():find(god) then
          hasMonument = god
          addMonument(god, vnum, room, area)
        end
      end
    end
  end
  for god, gTable in pairs(tw.shrines) do
    tw.shrines[god].shrines = tw.shrines[god].shrines or {}
    tw.shrines[god].monuments = tw.shrines[god].monuments or {}
    if gTable.shrines[vnum] then
      if god ~= hasShrine then
        removeShrine(god, vnum)
        cecho("\nRemoved missing shrine at " .. vnum .. " for " .. god:title())
      end
    end
    if gTable.monuments[vnum] then
      if god ~= hasMonument then
        removeMonument(god, vnum)
        cecho("\nRemoved missing monument at " .. vnum .. " for " .. god:title())
      end
    end
  end
end

------------------------

function addShrine(god, vnum, room, area)
  tw.shrines = tw.shrines or {}
  tw.shrines[god] = tw.shrines[god] or {}
  tw.shrines[god].shrines = tw.shrines[god].shrines or {}
  tw.shrines[god].shrines[vnum] = {name = room, area = area:gsub("an unstable section of ", "")}
  table.save(getMudletHomeDir() .. "\\shrines.lua", tw)
end

------------------------

function removeShrine(god, vnum)
  tw.shrines = tw.shrines or {}
  tw.shrines[god] = tw.shrines[god] or {}
  tw.shrines[god].shrines = tw.shrines[god].shrines or {}
  tw.shrines[god].shrines[vnum] = nil
  table.save(getMudletHomeDir() .. "\\shrines.lua", tw)
end

-----------------------

function addMonument(god, vnum, room, area)
  tw.shrines = tw.shrines or {}
  tw.shrines[god] = tw.shrines[god] or {}
  tw.shrines[god].monuments = tw.shrines[god].monuments or {}
  tw.shrines[god].monuments[vnum] = {name = room, area = area:gsub("an unstable section of ", "")}
  table.save(getMudletHomeDir() .. "\\shrines.lua", tw)
end

------------------------

function removeMonument(god, vnum)
  tw.shrines = tw.shrines or {}
  tw.shrines[god] = tw.shrines[god] or {}
  tw.shrines[god].monuments = tw.shrines[god].monuments or {}
  tw.shrines[god].monuments[vnum] = nil
  table.save(getMudletHomeDir() .. "\\shrines.lua", tw)
end