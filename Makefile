# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flima <flima@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/01/17 20:15:01 by flima             #+#    #+#              #
#    Updated: 2025/01/17 21:30:54 by flima            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

CLIENT = client
SERVER = server

INCLUDE = includes
CC = cc
CFLAGS = -Wall -Werror -Wextra -g

OBJS_DIR = objs
SRCS_DIR = src
LIBFT_DIR = Libft
LIBFT = $(LIBFT_DIR)/libft.a
LIBS = -L$(LIBFT_DIR) -lft

CLIENT_SRCS = $(SRC_DIR)/client/client.c
SERVER_SRCS = $(SRC_DIR)/server/server.c
OBJ_CLIENT = $(CLIENT_SRCS:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)
OBJ_SERVER = $(SERVER_SRCS:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)

all: $(CLIENT) $(SERVER)

$(CLIENT): $(CLIENT_OBJS) $(LIBFT)
	@$(CC) $(CFLAGS) $(CLIENT_OBJS) $(LIBS) -I$(INCLUDE) -o $(CLIENT)

$(SERVER): $(SERVER_OBJS) $(LIBFT)
	@$(CC) $(CFLAGS) $(SERVER_OBJS) $(LIBS) -I$(INCLUDE) -o $(SERVER)

$(LIBFT):
	$(MAKE) -C $(LIBFT_DIR)

$(OBJS_DIR)/%.o : $(SRC_DIR)/%.c $(INC_DIR)/minitalk
	@mkdir -p $(dir $@)
	@$(CC) $(CFLAGS) -c $< -o $@ -I$(INCLUDE)

clean:
	@rm -rf $(OBJS_DIR)
	@$(MAKE) clean -C Libft

fclean:
	@rm -f $(CLIENT)
	@rm -f $(SERVER)
	@$(MAKE) fclean -C Libft

re: fclean all

.PHONY: all clean fclean re bonus

	