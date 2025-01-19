# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: filipe <filipe@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/01/17 20:15:01 by flima             #+#    #+#              #
#    Updated: 2025/01/19 14:35:42 by filipe           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

CLIENT = client
SERVER = server
CLIENT_BONUS = client_bonus
SERVER_BONUS = server_bonus

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

CLIENT_SRCS_BONUS = src/client/client_bonus.c
SERVER_SRCS_BONUS = src/server/server_bonus.c
CLIENT_OBJS_BONUS = $(addprefix $(OBJS_DIR), $(CLIENT_SRCS_BONUS:%.c=%.o))
SERVER_OBJS_BONUS = $(addprefix $(OBJS_DIR), $(SERVER_SRCS_BONUS:%.c=%.o))

all: $(CLIENT) $(SERVER)

$(CLIENT): $(CLIENT_OBJS) $(LIBFT)
	$(CC) $(CFLAGS) $(CLIENT_OBJS) $(LIBS) -I$(INCLUDE) -o $(CLIENT)

$(SERVER): $(SERVER_OBJS) $(LIBFT)
	$(CC) $(CFLAGS) $(SERVER_OBJS) $(LIBS) -I$(INCLUDE) -o $(SERVER)

$(LIBFT):
	$(MAKE) -C $(LIBFT_DIR)

$(OBJS_DIR)%.o : %.c $(INCLUDE)/minitalk.h $(INCLUDE)/minitalk_bonus.h
	@mkdir -p $(dir $@)
	@$(CC) $(CFLAGS) -c $< -o $@ -I$(INCLUDE)

bonus: $(CLIENT_BONUS) $(SERVER_BONUS)

$(CLIENT_BONUS): $(CLIENT_OBJS_BONUS) $(LIBFT)
	$(CC) $(CFLAGS) $(CLIENT_OBJS_BONUS) $(LIBS) -I$(INCLUDE) -o $(CLIENT_BONUS)

$(SERVER_BONUS): $(SERVER_OBJS_BONUS) $(LIBFT)
	$(CC) $(CFLAGS) $(SERVER_OBJS_BONUS) $(LIBS) -I$(INCLUDE) -o $(SERVER_BONUS)
	
clean:
	@rm -rf $(OBJS_DIR)
	@$(MAKE) clean -C Libft

fclean: clean
	@rm -f $(CLIENT)
	@rm -f $(SERVER)
	@rm -f $(CLIENT_BONUS)
	@rm -f $(SERVER_BONUS)
	@$(MAKE) fclean -C Libft

re: fclean all

.PHONY: all clean fclean re bonus

	