/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   minitalk.h                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: flima <flima@student.42.fr>                +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/01/17 16:21:26 by flima             #+#    #+#             */
/*   Updated: 2025/01/17 20:44:57 by flima            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef MINITALK_H
# define MINITALK_H

# include "libft.h"
# include <signal.h>

void	send_string(int pid, char *str);
void	send_char(int pid, unsigned char chr);
void	send_bit(int pid, int bit);
// server
void	signal_handler(int sig, siginfo_t *info, void *context);
#endif