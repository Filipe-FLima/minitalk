# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flima <flima@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/01/17 20:15:01 by flima             #+#    #+#              #
#    Updated: 2025/01/18 16:28:16 by flima            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

CLIENT = client
SERVER = server

INCLUDE = includes
CC = cc
CFLAGS = -Wall -Werror -Wextra -g

OBJS_DIR = objs/
LIBFT_DIR = Libft
LIBFT = $(LIBFT_DIR)/libft.a
LIBS = -L$(LIBFT_DIR) -lft

CLIENT_SRCS = src/client/client.c
SERVER_SRCS = src/server/server.c
CLIENT_OBJS = $(addprefix $(OBJS_DIR), $(CLIENT_SRCS:%.c=%.o))
SERVER_OBJS = $(addprefix $(OBJS_DIR), $(SERVER_SRCS:%.c=%.o))

all: $(CLIENT) $(SERVER)

$(CLIENT): $(CLIENT_OBJS) $(LIBFT)
	$(CC) $(CFLAGS) $(CLIENT_OBJS) $(LIBS) -I$(INCLUDE) -o $(CLIENT)

$(SERVER): $(SERVER_OBJS) $(LIBFT)
	$(CC) $(CFLAGS) $(SERVER_OBJS) $(LIBS) -I$(INCLUDE) -o $(SERVER)

$(LIBFT):
	$(MAKE) -C $(LIBFT_DIR)

$(OBJS_DIR)%.o : %.c $(INCLUDE)/minitalk.h
	@mkdir -p $(dir $@)
	@$(CC) $(CFLAGS) -c $< -o $@ -I$(INCLUDE)

clean:
	@rm -rf $(OBJS_DIR)
	@$(MAKE) clean -C Libft

fclean: clean
	@rm -f $(CLIENT)
	@rm -f $(SERVER)
	@$(MAKE) fclean -C Libft

re: fclean all

.PHONY: all clean fclean re bonus

	