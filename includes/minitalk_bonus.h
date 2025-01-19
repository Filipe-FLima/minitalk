/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   minitalk_bonus.h                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: filipe <filipe@student.42.fr>              +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/01/19 13:25:33 by filipe            #+#    #+#             */
/*   Updated: 2025/01/19 14:36:33 by filipe           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef MINITALK_BONUS_H
# define MINITALK_BONUS_H

# include "libft.h"
# include <signal.h>
#

//client functions
void	signal_confirmation(int signal);
void	send_string(int pid, char *str);
void	send_char(int pid, unsigned char chr);
void	send_bit(int pid, int bit);
//server functions
void	signal_handler(int sig, siginfo_t *info, void *context);
#endif