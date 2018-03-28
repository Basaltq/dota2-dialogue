"use strict";

var facing = 0

GameEvents.Subscribe( "dialog_pass_info", UpdateDialog);
GameEvents.Subscribe( "dialog_close", CloseDialog);

function UpdateDialog( event_data )
{
    $.Msg( "UpdateDialog: ", event_data );

    var speaker = event_data.speaker

    $.Msg(Entities.GetUnitLabel(speaker))
    //$("#Otsake").text = Entities.GetDisplayedUnitName(speaker)
    $("#Potretti").heroname = Entities.GetClassname(speaker)
    $("#Teksti").text = event_data.message

    facing = Entities.GetForward(speaker)
    facing = Math.atan2(facing[0], facing[1]) * 180 / Math.PI

    GameUI.SetCameraTarget(speaker)
    GameUI.SetCameraYaw(facing - 180)

    if (event_data.sound)
        Game.EmitSound(event_data.sound)
}
 

function LoadText() {

    GameUI.SetCameraDistance(200)
    GameUI.SetCameraPitchMax(30)
    GameUI.SetCameraLookAtPositionHeightOffset(120)
}

function PressedOkay(data)
{
    $.Msg("Okei miksi näitä lähtee mijoona?")

    GameEvents.SendCustomGameEventToServer( "dialog_closed", { } );
}

function CloseDialog(args)
{
    GameUI.SetCameraTarget(-1)
    GameUI.SetCameraYaw(-1);
    GameUI.SetCameraDistance(-1);
    GameUI.SetCameraPitchMax(-1)
    GameUI.SetCameraLookAtPositionHeightOffset(-1)
    $.GetContextPanel().GetParent().RemoveAndDeleteChildren()
}