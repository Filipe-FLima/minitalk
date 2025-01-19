# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: filipe <filipe@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/01/17 20:15:01 by flima             #+#    #+#              #
#    Updated: 2025/01/19 20:07:27 by filipe           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

CLIENT = client
SERVER = server
CLIENT_BONUS = client_bonus
SERVER_BONUS = server_bonus

INCLUDE = includes
CC = cc
CFLAGS = -Wall -Werror -Wextra -g

MSG = 1
MSG_B = 2
RESET   = \033[0m
GREEN   = \033[32m
YELLOW  = \033[33m
BLUE    = \033[34m

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

all: $(MSG) $(CLIENT) $(SERVER)

$(MSG):
	@echo "\n$(BLUE)Compiling client and server programs...$(RESET)\n"
	
$(CLIENT): $(CLIENT_OBJS) $(LIBFT)
	@$(CC) $(CFLAGS) $(CLIENT_OBJS) $(LIBS) -I$(INCLUDE) -o $(CLIENT)
	@echo "$(GREEN)client  [OK]$(RESET)"

$(SERVER): $(SERVER_OBJS) $(LIBFT)
	@$(CC) $(CFLAGS) $(SERVER_OBJS) $(LIBS) -I$(INCLUDE) -o $(SERVER)
	@echo "$(GREEN)server  [OK]$(RESET)\n"

$(LIBFT):
	@$(MAKE) --no-print-directory -C $(LIBFT_DIR)

$(OBJS_DIR)%.o : %.c $(INCLUDE)/minitalk.h $(INCLUDE)/minitalk_bonus.h
	@mkdir -p $(dir $@)
	@$(CC) $(CFLAGS) -c $< -o $@ -I$(INCLUDE)

bonus: $(MSG_B) $(CLIENT_BONUS) $(SERVER_BONUS)

$(MSG_B):
	@echo "\n$(BLUE)Compiling BONUS part$(RESET)\n"
	
$(CLIENT_BONUS): $(CLIENT_OBJS_BONUS) $(LIBFT)
	@$(CC) $(CFLAGS) $(CLIENT_OBJS_BONUS) $(LIBS) -I$(INCLUDE) -o $(CLIENT_BONUS)
	@echo "$(GREEN)client_bonus [OK]$(RESET)\n"

$(SERVER_BONUS): $(SERVER_OBJS_BONUS) $(LIBFT)
	@$(CC) $(CFLAGS) $(SERVER_OBJS_BONUS) $(LIBS) -I$(INCLUDE) -o $(SERVER_BONUS)
	@echo "$(GREEN)server_bonus [OK]$(RESET)\n"
	
clean:
	@$(MAKE) --no-print-directory clean -C Libft
	@echo "$(GREEN)Object files removed minitalk [OK]$(RESET)\n"
	@rm -rf $(OBJS_DIR)

fclean: clean
	@$(MAKE) --no-print-directory fclean -C Libft
	@echo "$(GREEN)Executable files removed minitalk [OK]$(RESET)\n"
	@rm -f $(CLIENT)
	@rm -f $(SERVER)
	@rm -f $(CLIENT_BONUS)
	@rm -f $(SERVER_BONUS)

re: fclean all

.PHONY: all clean fclean re bonus

	