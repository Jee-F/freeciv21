/**************************************************************************
 Copyright (c) 1996-2020 Freeciv21 and Freeciv contributors. This file is
 part of Freeciv21. Freeciv21 is free software: you can redistribute it
 and/or modify it under the terms of the GNU  General Public License  as
 published by the Free Software Foundation, either version 3 of the
 License,  or (at your option) any later version. You should have received
 a copy of the GNU General Public License along with Freeciv21. If not,
 see https://www.gnu.org/licenses/.
**************************************************************************/

// common
#include "game.h"
/* client */
#include "chatline_common.h"
#include "packhand_gen.h"
// gui-qt
#include "connectdlg.h"
#include "connectdlg_g.h"
#include "fc_client.h"
#include "pages_g.h"
#include "page_network.h"
#include "qtg_cxxside.h"

/**********************************************************************/ /**
   Close and destroy the dialog. But only if we don't have a local
   server running (that we started).
 **************************************************************************/
void qtg_close_connection_dialog()
{
  if (king()->current_page() != PAGE_NETWORK) {
    qtg_real_set_client_page(PAGE_MAIN);
  }
}

/**********************************************************************/ /**
   Configure the dialog depending on what type of authentication request the
   server is making.
 **************************************************************************/
void handle_authentication_req(enum authentication_type type,
                               const char *message)
{
  qobject_cast<page_network *>(king()->pages[PAGE_NETWORK])
      ->handle_authentication_req(type, message);
}

/**********************************************************************/ /**
   Provide a packet handler for packet_game_load.

   This regenerates the player information from a loaded game on the
   server.
 **************************************************************************/
void handle_game_load(bool load_successful, const char *filename)
{
  if (load_successful) {
    set_client_page(PAGE_START);

    if (game.info.is_new_game) {
      /* It's pregame. Create a player and connect to him */
      send_chat("/take -");
    }
  }
}

