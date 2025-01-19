/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   client_bonus.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: filipe <filipe@student.42.fr>              +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/01/19 13:24:34 by filipe            #+#    #+#             */
/*   Updated: 2025/01/19 13:47:21 by filipe           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "minitalk_bonus.h"

int	g_signal_sent = 0;

void	signal_confirmation(int signal)
{
	if (signal == SIGUSR1)
		g_signal_sent = 1;
	else
		ft_printf("The message was sent.\n");
}

void	send_bit(int pid, int bit)
{
	int	signal;
	int	i;

	if (bit == 0)
		signal = SIGUSR1;
	else
		signal = SIGUSR2;
	i = kill(pid, signal);
	if (i == -1)
	{
		ft_putstr_fd("Error sending the signal\n", 2);
		exit(EXIT_FAILURE);
	}
	while (!g_signal_sent)
		usleep(1);
	g_signal_sent = 0;
}

void	send_char(int pid, unsigned char chr)
{
	int	bit;
	int	i;

	i = 7;
	while (i >= 0)
	{
		bit = ((chr >> i) & 1);
		send_bit(pid, bit);
		i--;
	}
}

void	send_string(int pid, char *str)
{
	while (*str)
		send_char(pid, *str++);
	send_char(pid, '\0');
	send_char(pid, '\n');
}

int	main(int argc, char **argv)
{
	pid_t	pid;

	if (argc != 3)
	{
		ft_putstr_fd("Error\nInput: ./client [SERVER PID] [STRING]\n", 2);
		exit(EXIT_FAILURE);
	}
	pid = ft_atoi(argv[1]);
	if (pid <= 0)
	{
		ft_putstr_fd("Error\nInvalid PID.\n", 2);
		exit(EXIT_FAILURE);
	}
	signal(SIGUSR1, signal_confirmation);
	signal(SIGUSR2, signal_confirmation);
	send_string(pid, argv[2]);
	return (0);
}
