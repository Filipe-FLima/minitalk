# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flima <flima@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/01/17 20:15:01 by flima             #+#    #+#              #
#    Updated: 2025/01/17 20:45:46 by flima            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

CLIENT = client
SERVER = server

INCLUDE = includes
CC = cc
CFLAGS = -Wall -Werror -Wextra -g

LIBFT = Libft/libft.a
OBJS_DIR = objs/

CLIENT_SRCS = src/client/client.c
SERVER_SRCS = src/server/server.c

CLIENT_OBJS = $(addprefix $(OBJS_DIR), $(CLIENT_SRCS:.c=.o))
SERVER_OBJS = $(addprefix $(OBJS_DIR), $(SERVER_SRCS:.c=.o))

all: $(CLIENT) $(SERVER)

$(CLIENT): $(CLIENT_OBJS) $(LIBFT)
	@$(CC) $(CFLAGS) $(LIBFT) -o $(CLIENT) -I$(INCLUDE)

$(SERVER): $(SERVER_OBJS) $(LIBFT)
	@$(CC) $(CFLAGS) $(LIBFT) -o $(CLIENT) -I$(INCLUDE)

$(OBJS_DIR)%.o : %.c
	@mkdir -p $(OBJS_DIR)
	@mkdir -p $(OBJS_DIR)/src
	@mkdir -p $(OBJS_DIR)/src/client
	@mkdir -p $(OBJS_DIR)/src/server
	@$(CC) $(CFLAGS) -c $< -o $@ -I$(INCLUDE)
	
clean:
	@rm -rf $(OBJS_DIR)
	@$(MAKE) clean -C Libft

fclean:
	@rm -f $(CLIENT)
	@rm -f $(CLIENT)
	@$(MAKE) fclean -C Libft

re: fclean all

.PHONY: all clean fclean re bonus
	